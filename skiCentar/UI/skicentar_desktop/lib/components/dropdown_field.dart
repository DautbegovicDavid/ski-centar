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
    return Expanded(
      child: FormBuilderDropdown<String>(
        name: name,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 14.0), // Adjust padding as needed
          labelStyle: const TextStyle(fontSize: 16),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
        items: items,
        validator: FormBuilderValidators.compose(validators ?? []),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';

// class DropdownField extends StatelessWidget {
//   final String name;
//   final String labelText;
//   final List<DropdownMenuItem<String>> items;

//   const DropdownField({
//     Key? key,
//     required this.name,
//     required this.labelText,
//     required this.items,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50, // Adjust the height as needed
//       width: 200, // Adjust the width as needed
//       child: FormBuilderDropdown<String>(
//         name: name,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // Adjust padding as needed
//           labelText: labelText,
//           labelStyle: const TextStyle(fontSize: 14),
//           filled: true,
//           fillColor: Colors.grey[100],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: const BorderSide(color: Colors.blue),
//           ),
//         ),
//         style: const TextStyle(fontSize: 14), // Adjust font size as needed
//         items: items,
//       ),
//     );
//   }
// }

