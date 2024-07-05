import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final String name;
  final DateTime? initialValue;
  final DateTime? firstDate;
  final String labelText;
  final String dateFormat;
  final bool enabled;
  final List<FormFieldValidator<DateTime>>? validators;

  const DatePickerField(
      {Key? key,
      required this.name,
      this.initialValue,
      required this.labelText,
      this.dateFormat = 'dd-MM-yyyy',
      this.enabled = true,
      this.validators,
      this.firstDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      initialValue: initialValue,
      name: name,
      inputType: InputType.date,
      format: DateFormat(dateFormat),
      firstDate: firstDate,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
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
    );
  }
}
