import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/dropdown_field.dart';
import 'package:skicentar_desktop/components/form_wrapper.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/components/toggle_field.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/models/user-role.dart';
import 'package:skicentar_desktop/models/user.dart';
import 'package:skicentar_desktop/providers/user_provider.dart';
import 'package:skicentar_desktop/providers/user_role_provider.dart';
import 'package:skicentar_desktop/utils/utils.dart';

class UserAddScreen extends StatefulWidget {
  final User? user;
  const UserAddScreen({super.key, this.user});

  @override
  State<UserAddScreen> createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late UserProvider userProvider;
  late UserRoleProvider userRoleProvider;
  SearchResult<UserRole>? userRolesResult;

  @override
  void initState() {
    userProvider = context.read<UserProvider>();
    userRoleProvider = context.read<UserRoleProvider>();

    super.initState();
    initForm();
  }

  Future initForm() async {
    _initialValue = {
      'email': widget.user?.email.toString(),
      'password': null,
      'userRoleId': widget.user?.userRoleId.toString(),
      'isVerified': widget.user?.isVerified ?? false,
    };
    userRolesResult = await userRoleProvider.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        widget.user == null ? "Add new employee" : "Edit employee",
        Column(children: [
          FormWrapper(children: [_buildForm(), _saveRow()]),
        ]),
        true,
        false);
  }

  Widget _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InputField(
                name: "email",
                labelText: "Email",
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              const SizedBox(width: 10),
              if(widget.user == null)
              InputField(
                name: "password",
                labelText: "Password",
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              DropdownField(
                name: "userRoleId",
                labelText: "Role",
                validators: [
                  FormBuilderValidators.required(),
                ],
                items: userRolesResult?.result
                        .map((item) => DropdownMenuItem<String>(
                            value: item.id.toString(),
                            child: Text(item.name ?? "")))
                        .toList() ??
                    [],
              ),
              const SizedBox(width: 10),
              const ToggleField(
                name: "isVerified",
                title: "Verified",
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _saveRow() {
    return Row(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
              onPressed: _saveUser,
              child: const Text("Save")),
        ),
      ],
    );
  }

  Future _saveUser() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      try {
        if (widget.user == null) {
          await userProvider.createEmployee(_formKey.currentState?.value);
        } else {
          await userProvider.update(
              widget.user!.id!, _formKey.currentState?.value);
        }
        if (!context.mounted) return;
        showCustomSnackBar(
            context, Icons.check, Colors.green, 'Employee saved successfully!');
        Navigator.of(context).pop();
      } catch (e) {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Failed to save employee. Please try again.');
      }
    }
  }
}
