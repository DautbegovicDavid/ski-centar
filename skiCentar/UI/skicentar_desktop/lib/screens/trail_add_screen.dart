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
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/models/trail.dart';
import 'package:skicentar_desktop/models/trail_difficulty.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/providers/trail_difficulty.provider.dart';
import 'package:skicentar_desktop/providers/trail_provider.dart';
import 'package:skicentar_desktop/screens/map_screen.dart';
import 'package:skicentar_desktop/utils/utils.dart';

import '../components/dropdown_field.dart';

class TrailAddScreen extends StatefulWidget {
  final Trail? trail;
  const TrailAddScreen({super.key, this.trail});

  @override
  State<TrailAddScreen> createState() => _TrailAddScreenState();
}

class _TrailAddScreenState extends State<TrailAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late ResortProvider resortProvider;
  late TrailDifficultyProvider trailDifficultyProvider;
  late TrailProvider trailProvider;
  bool loaded = false;
  SearchResult<TrailDifficulty>? trailDifficultiesResult;
  SearchResult<Resort>? resortsResult;
  List<LatLng> addedLocations = [];
  List<String> allowedActions = [];

  @override
  void initState() {
    resortProvider = context.read<ResortProvider>();
    trailDifficultyProvider = context.read<TrailDifficultyProvider>();
    trailProvider = context.read<TrailProvider>();
    super.initState();
    if (widget.trail != null && widget.trail!.trailLocations!.isNotEmpty) {
      addedLocations = convertToLatLng(widget.trail!.trailLocations!); // TO DO
    }
    _initialValue = {
      'name': widget.trail?.name.toString(),
      'length': widget.trail?.length.toString(),
      'difficultyId': widget.trail?.difficultyId.toString(),
      'resortId': widget.trail?.resortId.toString(),
      'isFunctional': widget.trail?.isFunctional
    };
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
    trailDifficultiesResult = await trailDifficultyProvider.get();
    resortsResult = await resortProvider.get();
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        widget.trail == null ? "Add new ski track" : "Edit ski track",
        Column(children: [
          FormWrapper(children: [_buildForm(), _saveRow()]),
          _buildInfoBox(),
          MarkersPage(
              onLocationsAdded: _onLocationsAdded,
              initialMarkers: addedLocations,
              maxNumberOfMarkers: 10)
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
                name: "name",
                labelText: "Name",
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              const SizedBox(width: 10),
              InputField(
                name: "length",
                labelText: "Length",
                keyboardType: TextInputType.number,
                validators: [
                  FormBuilderValidators.required(),
                ],
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              DropdownField(
                name: "difficultyId",
                labelText: "Difficulty",
                validators: [
                  FormBuilderValidators.required(),
                ],
                items: trailDifficultiesResult?.result
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
              const ToggleField(
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(onPressed: _saveTrail, child: const Text("Save")),
        ),
      ],
    );
  }

  Future _saveTrail() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      if (addedLocations.length < 2) {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Failed to save trail. Lift has two or more marker point.');
        return;
      }
      Map<String, dynamic> trailObj =
          Map<String, dynamic>.from(_formKey.currentState?.value ?? {});
      trailObj['trailLocations'] = addedLocations
          .map((loc) => {
                'locationX': loc.latitude.degrees,
                'locationY': loc.longitude.degrees,
              })
          .toList();
      try {
        if (widget.trail == null) {
          await trailProvider.insert(trailObj);
        } else {
          await trailProvider.update(widget.trail!.id!, trailObj);
        }
        if (!context.mounted) return;
        showCustomSnackBar(context, Icons.check, Colors.green,
            'Ski track saved successfully!');
        Navigator.of(context).pop();
      } catch (e) {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Failed to save ski track. Please try again.');
      }
    }
  }

  Widget _buildInfoBox() {
    return InfoBox(
      markersAdded: addedLocations.length,
      message:
          'Ski Track has a starting, ending and additional points. Maximum number of markers is 10.',
      maxMarkers: 10,
    );
  }
}
