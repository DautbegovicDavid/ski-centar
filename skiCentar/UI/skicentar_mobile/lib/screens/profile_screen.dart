import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/components/date_picker_field.dart';
import 'package:skicentar_mobile/components/input_field.dart';
import 'package:skicentar_mobile/models/user.dart';
import 'package:skicentar_mobile/providers/user_detail_provider.dart';
import 'package:skicentar_mobile/providers/user_provider.dart';
import 'package:skicentar_mobile/screens/login_screen.dart';
import 'package:skicentar_mobile/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  late UserProvider userProvider;
  late UserDetailProvider userDetailProvider;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  @override
  void initState() {
    userProvider = context.read<UserProvider>();
    userDetailProvider = context.read<UserDetailProvider>();
    super.initState();
    _fetchUser();
  }

  Future<void> initForm() async {
    setState(() {
      _initialValue = {
        'email': user?.email ?? '',
        'registrationDate': user?.registrationDate ?? '',
        'name': user?.userDetails?.name ?? '',
        'lastName': user?.userDetails?.lastName ?? '',
        'dateOfBirth': user?.userDetails?.dateOfBirth ?? '',
      };
    });
  }

  Future<void> _fetchUser() async {
    try {
      final fetchedUser = await userProvider.getDetails();
      setState(() {
        user = fetchedUser;
        initForm();
      });
    } catch (e) {
      print('Failed to load user: $e');
    }
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

  Future _save() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      var formValues =
          Map<String, dynamic>.from(_formKey.currentState?.value ?? {});
      formValues.removeWhere((key, value) => value == '');
      formValues['dateOfBirth'] = formatDateTime(formValues['dateOfBirth']);
      formValues.remove('email');
      formValues.remove('registrationDate');

      try {
        if (user?.userDetails == null) {
          formValues['userId'] = user!.id;
          await userDetailProvider.insert(formValues);
        } else {
          formValues['id'] = user!.userDetails!.id;
          await userDetailProvider.update(user!.userDetails!.id!, formValues);
        }
        await _fetchUser();
        if (!context.mounted) return;
        showCustomSnackBar(context, Icons.check, Colors.green,
            'Your details have been saved successfully!');
      } catch (e) {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Failed to save details. Please try again.');
      }
    }
  }

  Widget _buildForm() {
    // return Text("hehe");'
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildLogoutButton(),
                  const SizedBox(height: 30),
                  const InputField(
                    name: "email",
                    labelText: "Email",
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  const DatePickerField(
                    name: "registrationDate",
                    labelText: "Registered ",
                    enabled: false,
                  ),
                  const SizedBox(height: 20),
                  const InputField(
                    name: "name",
                    labelText: "Name",
                  ),
                  const SizedBox(height: 16),
                  const InputField(
                    name: "lastName",
                    labelText: "Last name",
                  ),
                  const SizedBox(height: 16),
                  const DatePickerField(
                    name: "dateOfBirth",
                    labelText: "Date of Birth",
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: _save,
                          child: const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildLogoutButton() {
    return Row(
      children: [
        Icon(Icons.person_sharp, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        const Text(
          "My profile",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: _logout,
          child: const Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: user == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [_buildForm()],
                ),
              ));
  }
}
