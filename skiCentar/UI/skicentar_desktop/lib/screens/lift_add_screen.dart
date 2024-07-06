import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:latlng/latlng.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/form_wrapper.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/components/map_info_box.dart';
import 'package:skicentar_desktop/components/toggle_field.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/lift-type.dart';
import 'package:skicentar_desktop/models/lift.dart';
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/providers/lift_provider.dart';
import 'package:skicentar_desktop/providers/lift_type_provider.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/screens/map_screen.dart';
import 'package:skicentar_desktop/utils/utils.dart';

import '../components/dropdown_field.dart';

class LiftAddScreen extends StatefulWidget {
  final Lift? lift;
  const LiftAddScreen({super.key, this.lift});
  @override
  State<LiftAddScreen> createState() => _LiftAddScreenState();
}

class _LiftAddScreenState extends State<LiftAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late ResortProvider resortProvider;
  late LiftTypeProvider liftTypeProvider;
  late LiftProvider liftProvider;
  bool loaded = false;
  SearchResult<LiftType>? liftTypesResult;
  SearchResult<Resort>? resortsResult;
  List<LatLng> addedLocations = [];
  List<String> allowedActions = [];
  bool hideSaveButton = false;

  @override
  void initState() {
    resortProvider = context.read<ResortProvider>();
    liftTypeProvider = context.read<LiftTypeProvider>();
    liftProvider = context.read<LiftProvider>();
    super.initState();
    if (widget.lift != null && widget.lift!.liftLocations!.isNotEmpty) {
      addedLocations = convertToLatLng(widget.lift!.liftLocations!);
    }
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _onLocationsAdded(List<LatLng> locations) {
    setState(() {
      addedLocations = locations;
    });
  }

  Future initForm() async {
    _initialValue = {
      'name': widget.lift?.name.toString(),
      'capacity': widget.lift?.capacity.toString(),
      'liftTypeId': widget.lift?.liftTypeId.toString(),
      'resortId': widget.lift?.resortId.toString(),
      'isFunctional': widget.lift?.isFunctional
    };
    liftTypesResult = await liftTypeProvider.get();
    resortsResult = await resortProvider.get();
    if (widget.lift != null) {
      await getAllowedActions();
    }
    setState(() {
      loaded = true;
      updateHideSaveButton();
    });
  }

  Future getAllowedActions() async {
    allowedActions = await liftProvider.getAllowedActions(widget.lift!.id!);
    setState(() {
      updateHideSaveButton();
    });
  }

  void updateHideSaveButton() {
    hideSaveButton = allowedActions.length == 1 &&
        (allowedActions.contains('Edit') || allowedActions.contains('Hide'));
  }

  Future _saveLift() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      if (addedLocations.length < 2) {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Failed to save lift. Lift has two marker point.');
        return;
      }
      Map<String, dynamic> liftObj =
          Map<String, dynamic>.from(_formKey.currentState?.value ?? {});
      liftObj['liftLocations'] = addedLocations
          .map((loc) => {
                'locationX': loc.latitude.degrees,
                'locationY': loc.longitude.degrees,
              })
          .toList();
      try {
        if (widget.lift == null) {
          await liftProvider.insert(liftObj);
        } else {
          await liftProvider.update(widget.lift!.id!, liftObj);
        }
        if (!context.mounted) return;
        showCustomSnackBar(
            context, Icons.check, Colors.green, 'Lift saved successfully!');
        Navigator.of(context).pop();
      } catch (e) {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Failed to save lift. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        widget.lift == null ? "Add new lift" : "Edit lift",
        Column(children: [
          FormWrapper(children: [_buildForm(), _saveRow()]),
          _buildInfoBox(),
          MarkersPage(
              onLocationsAdded: _onLocationsAdded,
              initialMarkers: addedLocations,
              maxNumberOfMarkers: 2)
        ]),
        true,
        false);
  }

  Widget _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      enabled: !hideSaveButton,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // ignore: prefer_const_constructors
              InputField(
                name: "name",
                labelText: "Name",
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              const SizedBox(width: 10),
              InputField(
                name: "capacity",
                labelText: "Capacity",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                name: "liftTypeId",
                labelText: "Lift type",
                validators: [
                  FormBuilderValidators.required(),
                ],
                items: liftTypesResult?.result
                        .map((item) => DropdownMenuItem<String>(
                            value: item.id.toString(),
                            child: Text(item.name ?? "")))
                        .toList() ??
                    [],
              ),
              const SizedBox(width: 10),
              DropdownField(
                name: "resortId",
                labelText: "Resort",
                validators: [
                  FormBuilderValidators.required(),
                ],
                items: resortsResult?.result
                        .map((item) => DropdownMenuItem(
                            value: item.id.toString(),
                            child: Text(item.name ?? "")))
                        .toList() ??
                    [],
              ),
              const SizedBox(width: 10),
              // ignore: prefer_const_constructors
              ToggleField(
                name: "isFunctional",
                title: "Functional",
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
        ...allowedActions.map((action) {
          Color buttonColor;
          switch (action.toLowerCase()) {
            case 'activate':
              buttonColor = Colors.green;
              break;
            case 'update':
              buttonColor = Colors.orange;
              break;
            case 'hide':
              buttonColor = Colors.red;
              break;
            default:
              buttonColor = Colors.grey;
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                switch (action.toLowerCase()) {
                  case 'activate':
                    await liftProvider.activate(widget.lift!.id!);
                    break;
                  case 'update':
                    await _saveLift();
                    break;
                  case 'hide':
                    await liftProvider.hide(widget.lift!.id!);
                    break;
                  case 'edit':
                    await liftProvider.edit(widget.lift!.id!);
                    break;
                }
                await getAllowedActions();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor, foregroundColor: Colors.white),
              child: Text(action),
            ),
          );
        }).toList(),
        if (!hideSaveButton && widget.lift == null) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                FilledButton(onPressed: _saveLift, child: const Text("Save")),
          ),
        ]
      ],
    );
  }

  Widget _buildInfoBox() {
    return InfoBox(
      markersAdded: addedLocations.length,
      message:
          'Lift has a starting and ending point. Maximum number of markers is two.',
    );
  }
}
