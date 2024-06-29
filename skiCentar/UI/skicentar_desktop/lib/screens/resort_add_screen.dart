import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/form_wrapper.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/utils/utils.dart';

class ResortAddScreen extends StatefulWidget {
  final Resort? resort;
  const ResortAddScreen({super.key, this.resort});

  @override
  State<ResortAddScreen> createState() => _ResortAddScreenState();
}

class _ResortAddScreenState extends State<ResortAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late ResortProvider resortProvider;

  @override
  void initState() {
    resortProvider = context.read<ResortProvider>();
    super.initState();
    _initialValue = {
      'name': widget.resort?.name.toString(),
      'location': widget.resort?.location.toString(),
      'elevation': widget.resort?.elevation.toString(),
      'skiWorkHours': widget.resort?.skiWorkHours.toString(),
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        widget.resort == null ? "Add new resort" : "Edit resort",
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
          const Row(
            children: [
              InputField(
                name: "name",
                labelText: "Name",
              ),
              SizedBox(width: 10),
              InputField(
                name: "location",
                labelText: "Location - Near Town",
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              InputField(
                name: "elevation",
                labelText: "Elevation",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(width: 10),
              const InputField(
                name: "skiWorkHours",
                labelText: "SKI work hours",
                keyboardType: TextInputType.number,
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
              onPressed: () async {
                _formKey.currentState?.saveAndValidate();
                try {
                  if (widget.resort == null) {
                    await resortProvider.insert(_formKey.currentState?.value);
                  } else {
                    await resortProvider.update(
                        widget.resort!.id!, _formKey.currentState?.value);
                  }
                  if (!context.mounted) return;
                  showCustomSnackBar(context, Icons.check, Colors.green,
                      'Resort saved successfully!');
                  Navigator.of(context).pop();
                } catch (e) {
                  showCustomSnackBar(context, Icons.error, Colors.red,
                      'Failed to save resort. Please try again.');
                }
              },
              child: const Text("Save")),
        ),
      ],
    );
  }
}
