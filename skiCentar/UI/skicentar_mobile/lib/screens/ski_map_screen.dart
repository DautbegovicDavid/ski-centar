import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/lift.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/models/trail.dart';
import 'package:skicentar_mobile/providers/lift_provider.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/providers/trail_provider.dart';

class SkiMapScreen extends StatefulWidget {
  @override
  State<SkiMapScreen> createState() => _SkiMapScreenState();
}

class _SkiMapScreenState extends State<SkiMapScreen> {
  late GoogleMapController mapController;

  LatLng _center =
      const LatLng(43.820, 18.313); // Center the map around a specific location

  late LiftProvider liftProvider;
  late TrailProvider trailProvider;
  late ResortProvider resortProvider;

  SearchResult<Trail>? trails;
  SearchResult<Lift>? lifts;

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  bool mapLoaded = false;

  @override
  void initState() {
    super.initState();
    liftProvider = context.read<LiftProvider>();
    trailProvider = context.read<TrailProvider>();
    resortProvider = context.read<ResortProvider>();
    resortProvider.addListener(_updateInfo);
    _fetchData();
  }

  void _updateInfo() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    trails = await trailProvider.get(filter: {
      'resortId': resortProvider.selectedResort?.id,
      'isResortIncluded': true,
      'isDifficultyIncluded': true,
      'areTrailLocationsIncluded': true,
    });
    lifts = await liftProvider.get(filter: {
      'ResortId': resortProvider.selectedResort?.id,
      'IsResortIncluded': true,
      'IsLiftTypeIncluded': true,
      'AreLiftLocationsIncluded': true,
    });
    _setMarkersAndPolylines();
    if (mounted) {
      setState(() {});
    }
  }

  Set<Polyline> combinePolylines(Set<Polyline> set1, Set<Polyline> set2) {
    final Set<Polyline> combinedSet = Set<Polyline>.from(set1);
    combinedSet.addAll(set2);
    return combinedSet;
  }

  void _setMarkersAndPolylines() {
    final Set<Marker> markers = lifts!.result.expand((lift) {
      return lift.liftLocations!.map((location) {
        return Marker(
          markerId: MarkerId('${lift.name}_${location.id}'),
          position: LatLng(location.locationX!, location.locationY!),
          infoWindow: InfoWindow(title: lift.name),
          icon: (lift.isFunctional ?? false)
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );
      });
    }).toSet();

    final Set<Polyline> liftPolylines = lifts!.result.map((lift) {
      return Polyline(
        polylineId: PolylineId('${lift.name}_polyline'),
        points: lift.liftLocations!
            .map((location) => LatLng(location.locationX!, location.locationY!))
            .toList(),
        color: (lift.isFunctional ?? false) ? Colors.green : Colors.red,
        width: 5,
      );
    }).toSet();

    final Set<Polyline> trailPolylines = trails!.result.map((lift) {
      return Polyline(
        polylineId: PolylineId('${lift.name}_polyline'),
        points: lift.trailLocations!
            .map((location) => LatLng(location.locationX!, location.locationY!))
            .toList(),
        color: (lift.isFunctional ?? false) ? Colors.green : Colors.red,
        width: 3,
      );
    }).toSet();

    Set<Polyline> combinedPolylines =
        combinePolylines(liftPolylines, trailPolylines);
    if (mounted) {
      setState(() {
        if (markers.isNotEmpty) {
          _center = markers.first.position;
        }
        _markers = markers;
        _polylines = combinedPolylines;
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
              polylines: _polylines,
            ),
    );
  }
}
