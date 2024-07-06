import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/models/ski_accident.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/providers/ski_accident_provider.dart';
import 'package:skicentar_mobile/utils/icons_helper.dart';

class SkiAccidentsScreen extends StatefulWidget {
  @override
  State<SkiAccidentsScreen> createState() => _SkiAccidentsScreenState();
}

class _SkiAccidentsScreenState extends State<SkiAccidentsScreen> {
  late GoogleMapController mapController;

  LatLng _center =
      const LatLng(43.820, 18.313);

  late SkiAccidentProvider accidentProvider;
  late ResortProvider resortProvider;

  SearchResult<SkiAccident>? accidents;

  Set<Marker> _markers = {};

  bool mapLoaded = false;

  @override
  void initState() {
    super.initState();
    accidentProvider = context.read<SkiAccidentProvider>();
    resortProvider = context.read<ResortProvider>();
    resortProvider.addListener(_updateInfo);
    _fetchData();
  }

  void _updateInfo() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    accidents = await accidentProvider.get(filter: {
      'IsActive': true
    });
    _setMarkers();
    if (mounted) {
      setState(() {});
    }
  }

  void _setMarkers() async {
    Map<String, BitmapDescriptor> categoryIcons = await getCategoryIcons();

    final Set<Marker> markers = accidents!.result.where((poi) {
      return poi.locationX != null &&
          poi.locationY != null;
    }).map((poi) {
      BitmapDescriptor icon = categoryIcons['Accidents'] ??
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      return Marker(
        markerId: MarkerId('${poi.id}'),
        position: LatLng(poi.locationX!, poi.locationY!),
        infoWindow: const InfoWindow(title: 'Active Ski Accident'),
        icon: icon,
      );
    }).toSet();

    if (mounted) {
      setState(() {
        if (markers.isNotEmpty) {
          _center = markers.first.position;
        }
        _markers = markers;
        if (mapLoaded) {
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
            ),
          );
        }
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _center,
          zoom: 14.0,
        ),
      ),
    );
    mapLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: resortProvider.selectedResort == null
          ? const Center(child: Text('Please select a resort'))
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              markers: _markers,
            ),
    );
  }
}
