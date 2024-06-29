import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class InputField extends StatelessWidget {
  final String name;
  final String labelText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;
  final List<FormFieldValidator<String>>? validators;

  const InputField({
    Key? key,
    required this.name,
    required this.labelText,
    this.keyboardType,
    this.inputFormatters,
    this.suffixText,
    this.validators,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FormBuilderTextField(
        name: name,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: labelText,
          suffixText: suffixText,
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
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
            borderSide: BorderSide(color: Theme.of(context).primaryColorLight),
          ),
        ),
        validator: FormBuilderValidators.compose(validators ?? []),
      ),
    );
  }
}
