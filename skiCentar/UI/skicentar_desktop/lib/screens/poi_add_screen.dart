import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:latlng/latlng.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/form_wrapper.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/location.dart';
import 'package:skicentar_desktop/models/poi_category.dart';
import 'package:skicentar_desktop/models/point_of_interest.dart';
import 'package:skicentar_desktop/models/resort.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/providers/poi_category_provider.dart';
import 'package:skicentar_desktop/providers/poi_provider.dart';
import 'package:skicentar_desktop/providers/resort_provider.dart';
import 'package:skicentar_desktop/screens/map_screen.dart';
import 'package:skicentar_desktop/utils/utils.dart';

import '../components/dropdown_field.dart';

class PoiAddScreen extends StatefulWidget {
  final PointOfInterest? pointOfInterest;
  const PoiAddScreen({super.key, this.pointOfInterest});
  @override
  State<PoiAddScreen> createState() => _PoiAddScreenState();
}

class _PoiAddScreenState extends State<PoiAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late ResortProvider resortProvider;
  late PoiCategoryProvider poiCategoryProvider;
  late PoiProvider provider;
  bool loaded = false;
  SearchResult<PoiCategory>? poiCategoriesResult;
  SearchResult<Resort>? resortsResult;
  List<LatLng> addedLocations = [];

  @override
  void initState() {
    resortProvider = context.read<ResortProvider>();
    poiCategoryProvider = context.read<PoiCategoryProvider>();
    provider = context.read<PoiProvider>();
    super.initState();
    if (widget.pointOfInterest != null &&
        widget.pointOfInterest!.locationX != null) {
      addedLocations = convertToLatLng([
        Location(
            locationX: widget.pointOfInterest!.locationX,
            locationY: widget.pointOfInterest!.locationY)
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
      'name': widget.pointOfInterest?.name.toString(),
      'description': widget.pointOfInterest?.description.toString(),
      'categoryId': widget.pointOfInterest?.categoryId.toString(),
      'resortId': widget.pointOfInterest?.resortId.toString(),
    };
    poiCategoriesResult = await poiCategoryProvider.get();
    resortsResult = await resortProvider.get();
    setState(() {});
  }

  Future _saveLift() async {
    _formKey.currentState?.saveAndValidate();
    Map<String, dynamic> poiObj =
        Map<String, dynamic>.from(_formKey.currentState?.value ?? {});
    if (addedLocations.isNotEmpty) {
      var firstLocation = addedLocations.first;
      poiObj['locationX'] = firstLocation.latitude.degrees;
      poiObj['locationY'] = firstLocation.longitude.degrees;
    }
    try {
      if (widget.pointOfInterest == null) {
        await provider.insert(poiObj);
      } else {
        await provider.update(widget.pointOfInterest!.id!, poiObj);
      }
      if (!context.mounted) return;
      showCustomSnackBar(context, Icons.check, Colors.green,
          'Point of interest saved successfully!');
      Navigator.of(context).pop();
    } catch (e) {
      showCustomSnackBar(context, Icons.error, Colors.red,
          'Failed to save point of interest. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        widget.pointOfInterest == null
            ? "Add new point of interest"
            : "Edit point of interest",
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
          const Row(
            children: [
              InputField(
                name: "name",
                labelText: "Name",
              ),
              SizedBox(width: 10),
              InputField(
                name: "description",
                labelText: "Description - brief info",
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              DropdownField(
                name: "categoryId",
                labelText: "Category",
                items: poiCategoriesResult?.result
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
                items: resortsResult?.result
                        .map((item) => DropdownMenuItem(
                            value: item.id.toString(),
                            child: Text(item.name ?? "")))
                        .toList() ??
                    [],
              ),
            ],
          ),
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
          child: ElevatedButton(
              onPressed: _saveLift,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text("Save")),
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
              'Point of interest has an unique location. Maximum number of markers is one.',
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
