import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/point_of_interest.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/providers/poi_provider.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/utils/icons_helper.dart';

class PoiScreen extends StatefulWidget {
  @override
  State<PoiScreen> createState() => _PoiScreenState();
}

class _PoiScreenState extends State<PoiScreen> {
  late GoogleMapController mapController;

  LatLng _center =
      const LatLng(43.820, 18.313); // Center the map around a specific location

  late PoiProvider poiProvider;
  late ResortProvider resortProvider;

  SearchResult<PointOfInterest>? pois;

  Set<Marker> _markers = {};

  bool mapLoaded = false;

  @override
  void initState() {
    super.initState();
    poiProvider = context.read<PoiProvider>();
    resortProvider = context.read<ResortProvider>();
    resortProvider.addListener(_updateInfo);
    _fetchData();
  }

  void _updateInfo() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    pois = await poiProvider.get(filter: {
      'ResortId': resortProvider.selectedResort?.id,
      'IsCategoryIncluded': true
    });
    _setMarkers();
    if (mounted) {
      setState(() {});
    }
  }

  void _setMarkers() async {
    Map<String, BitmapDescriptor> categoryIcons = await getCategoryIcons();

    final Set<Marker> markers = pois!.result.where((poi) {
      return poi.locationX != null &&
          poi.locationY != null &&
          poi.category != null;
    }).map((poi) {
      BitmapDescriptor icon = categoryIcons[poi.category!.name] ??
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      return Marker(
        markerId: MarkerId('${poi.name}_${poi.id}'),
        position: LatLng(poi.locationX!, poi.locationY!),
        infoWindow: InfoWindow(title: poi.description),
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
      body: resortProvider.selectedResort == null //provjeriti je li sve loadano
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
