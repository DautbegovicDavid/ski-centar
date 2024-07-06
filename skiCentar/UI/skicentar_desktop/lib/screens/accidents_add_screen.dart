import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:latlng/latlng.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/date_picker_field.dart';
import 'package:skicentar_desktop/components/form_wrapper.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/components/toggle_field.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/location.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/models/ski_accident.dart';
import 'package:skicentar_desktop/models/trail.dart';
import 'package:skicentar_desktop/models/user.dart';
import 'package:skicentar_desktop/providers/ski_accident_provider.dart';
import 'package:skicentar_desktop/providers/trail_provider.dart';
import 'package:skicentar_desktop/providers/user_provider.dart';
import 'package:skicentar_desktop/screens/map_screen.dart';
import 'package:skicentar_desktop/utils/utils.dart';

import '../components/dropdown_field.dart';

class AccidentsAddScreen extends StatefulWidget {
  final SkiAccident? accident;
  const AccidentsAddScreen({super.key, this.accident});
  @override
  State<AccidentsAddScreen> createState() => _AccidentsAddScreenState();
}

class _AccidentsAddScreenState extends State<AccidentsAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late SkiAccidentProvider provider;
  late TrailProvider trailProvider;
  late UserProvider userProvider;
  bool loaded = false;
  SearchResult<SkiAccident>? result;
  SearchResult<User>? userResult;
  SearchResult<Trail>? trailResult;

  List<LatLng> addedLocations = [];

  @override
  void initState() {
    provider = context.read<SkiAccidentProvider>();
    userProvider = context.read<UserProvider>();
    trailProvider = context.read<TrailProvider>();
    super.initState();
    if (widget.accident != null && widget.accident!.locationX != null) {
      addedLocations = convertToLatLng([
        Location(
            locationX: widget.accident!.locationX,
            locationY: widget.accident!.locationY)
      ]);
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
      'peopleInvolved': widget.accident?.peopleInvolved.toString(),
      'isReporterInjured': widget.accident?.isReporterInjured,
      'timestamp': widget.accident?.timestamp,
      'isActive': widget.accident?.isActive,
      'userId': widget.accident?.userId?.toString(),
      'trailId': widget.accident?.trailId?.toString(),
      'description': widget.accident?.description?.toString(),
    };
    userResult =
        await userProvider.get(filter: {'areUserDetailsIncluded': true});
    trailResult = await trailProvider.get();
    setState(() {});
  }

  Future _saveAccident() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      _formKey.currentState?.saveAndValidate();
      Map<String, dynamic> accidentPoi =
          Map<String, dynamic>.from(_formKey.currentState?.value ?? {});

      accidentPoi.removeWhere((key, value) => value == '');
      accidentPoi['timestamp'] = formatDateTime(accidentPoi['timestamp']);
      if (addedLocations.isNotEmpty) {
        var firstLocation = addedLocations.first;
        accidentPoi['locationX'] = firstLocation.latitude.degrees;
        accidentPoi['locationY'] = firstLocation.longitude.degrees;
      }
      try {
        await provider.update(widget.accident!.id!, accidentPoi);
        if (!context.mounted) return;
        showCustomSnackBar(context, Icons.check, Colors.green,
            'Accident updated successfully!');
        Navigator.of(context).pop();
      } catch (e) {
        showCustomSnackBar(context, Icons.error, Colors.red,
            'Failed to save point of interest. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Edit accident",
        Column(children: [
          FormWrapper(children: [_buildForm(), _saveRow()]),
          _buildInfoBox(),
          MarkersPage(
              onLocationsAdded: _onLocationsAdded,
              initialMarkers: addedLocations,
              maxNumberOfMarkers: 1)
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
              DropdownField(
                name: "userId",
                labelText: "Reported by",
                items: userResult?.result.map((item) {
                      String displayText;
                      if ((item.userDetails?.name?.isEmpty ?? true) &&
                          (item.userDetails?.lastName?.isEmpty ?? true)) {
                        displayText = item.email ?? "";
                      } else {
                        displayText =
                            '${item.userDetails!.name ?? ""} ${item.userDetails!.lastName ?? ""}'
                                .trim();
                      }
                      return DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(displayText),
                      );
                    }).toList() ??
                    [],
              ),
              const SizedBox(width: 10),
              const ToggleField(
                name: "isReporterInjured",
                title: "Is reporter injured",
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              InputField(
                name: "peopleInvolved",
                labelText: "People involved",
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3)
                ],
              ),
              const SizedBox(width: 10),
              DropdownField(
                name: "trailId",
                labelText: "Trail",
                items: trailResult?.result
                        .map((item) => DropdownMenuItem(
                            value: item.id.toString(),
                            child: Text(item.name ?? "")))
                        .toList() ??
                    [],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              DatePickerField(
                name: "timestamp",
                labelText: "Date time",
                dateFormat: 'MM/dd/yyyy hh:mm',
                enabled: false,
              ),
              SizedBox(width: 10),
              ToggleField(
                name: "isActive",
                title: "ACTIVE",
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(children: [
            InputField(
              name: "description",
              labelText: "Accident Details",
              maxLines: 3,
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(10),
              ],
            ),
          ]),
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
          child:
              FilledButton(onPressed: _saveAccident, child: const Text("Save")),
        ),
      ],
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(top: 8.0),
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Accident has an unique location. Maximum number of markers is one.',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Markers added: ${addedLocations.length}/1',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
