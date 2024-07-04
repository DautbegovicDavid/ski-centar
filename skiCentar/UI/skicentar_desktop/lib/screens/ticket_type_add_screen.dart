import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/dropdown_field.dart';
import 'package:skicentar_desktop/components/form_wrapper.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/components/toggle_field.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/models/ticket_type.dart';
import 'package:skicentar_desktop/models/ticket_type_seniority.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/providers/ticket_type_provider.dart';
import 'package:skicentar_desktop/providers/ticket_type_seniority_provider.dart';
import 'package:skicentar_desktop/utils/utils.dart';

class TicketTypeAddScreen extends StatefulWidget {
  final TicketType? ticketType;
  const TicketTypeAddScreen({super.key, this.ticketType});

  @override
  State<TicketTypeAddScreen> createState() => _TicketTypeAddScreenState();
}

class _TicketTypeAddScreenState extends State<TicketTypeAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late TicketTypeProvider provider;
  late TicketTypeSeniorityProvider seniorityProvider;
  late ResortProvider resortProvider;

  SearchResult<TicketTypeSeniority>? seniorities;
  SearchResult<Resort>? resorts;

  @override
  void initState() {
    provider = context.read<TicketTypeProvider>();
    seniorityProvider = context.read<TicketTypeSeniorityProvider>();
    resortProvider = context.read<ResortProvider>();
    super.initState();
    initForm();
  }

  Future initForm() async {
    _initialValue = {
      'price': widget.ticketType?.price.toString() ?? '',
      'ticketTypeSeniorityId':
          widget.ticketType?.ticketTypeSeniorityId.toString(),
           'resortId':
          widget.ticketType?.toString(),
      'fullDay': widget.ticketType?.fullDay ?? false,
    };
    seniorities = await seniorityProvider.get();
    resorts = await resortProvider.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        widget.ticketType == null ? "Add new ticket" : "Edit ticket",
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
                name: "price",
                labelText: "Price",
                keyboardType: TextInputType.number,
                validators: [FormBuilderValidators.required()],
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3)
                ],
              ),
              const SizedBox(width: 10),
              const ToggleField(
                name: "fullDay",
                title: "Full day",
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              DropdownField(
                validators: [FormBuilderValidators.required()],
                name: "ticketTypeSeniorityId",
                labelText: "Seniority",
                items: seniorities?.result
                        .map((item) => DropdownMenuItem<String>(
                            value: item.id.toString(),
                            child: Text(item.seniority ?? "")))
                        .toList() ??
                    [],
              ),
              const SizedBox(width: 10),
               DropdownField(
                validators: [FormBuilderValidators.required()],
                name: "resortId",
                labelText: "Resort",
                items: resorts?.result
                        .map((item) => DropdownMenuItem<String>(
                            value: item.id.toString(),
                            child: Text(item.name ?? "")))
                        .toList() ??
                    [],
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
              onPressed: _save,
              child: const Text("Save")),
        ),
      ],
    );
  }

  Future _save() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      try {
        if (widget.ticketType == null) {
          await provider.insert(_formKey.currentState?.value);
        } else {
          await provider.update(
              widget.ticketType!.id!, _formKey.currentState?.value);
        }
        if (!context.mounted) return;
        showCustomSnackBar(
            context, Icons.check, Colors.green, 'Ticket saved successfully!');
        Navigator.of(context).pop();
      } catch (e) {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Failed to save Ticket. Please try again.');
      }
    }
  }
}
