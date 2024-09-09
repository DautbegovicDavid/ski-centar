import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DropdownField extends StatelessWidget {
  final String name;
  final String labelText;
  final List<DropdownMenuItem<String>> items;
  final List<FormFieldValidator<String>>? validators;

  const DropdownField({
    Key? key,
    required this.name,
    required this.labelText,
    required this.items,
    this.validators,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
       FormBuilderDropdown<String>(
        name: name,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 14.0),
          labelStyle: const TextStyle(fontSize: 16),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Theme.of(context).focusColor),
          ),
        ),
        items: items,
        validator: FormBuilderValidators.compose(validators ?? []),
      );
  }
}