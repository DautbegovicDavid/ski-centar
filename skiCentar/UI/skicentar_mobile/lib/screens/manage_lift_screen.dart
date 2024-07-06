import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/lift.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/providers/lift_provider.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';

class ManageLiftScreen extends StatefulWidget {
  @override
  State<ManageLiftScreen> createState() => _ManageLiftScreenState();
}

class _ManageLiftScreenState extends State<ManageLiftScreen> {
  late GoogleMapController mapController;

  LatLng _center =
      const LatLng(43.820, 18.313);// Sarajevo

  late LiftProvider liftProvider;
  late ResortProvider resortProvider;

  SearchResult<Lift>? lifts;

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  bool mapLoaded = false;

  @override
  void initState() {
    super.initState();
    liftProvider = context.read<LiftProvider>();
    resortProvider = context.read<ResortProvider>();
    resortProvider.addListener(_updateInfo);
    _fetchData();
  }

  void _updateInfo() {
    _fetchData();
  }

  Future<void> _fetchData() async {
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
          onTap: () => _onMarkerTapped(lift),
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
        onTap: () => _onPolylineTapped(lift),
      );
    }).toSet();

    if (mounted) {
      setState(() {
        if (markers.isNotEmpty) {
          _center = markers.first.position;
        }
        _markers = markers;
        _polylines = liftPolylines;
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

  void _onMarkerTapped(Lift lift) {
    _showStatusDialog(lift);
  }

  void _onPolylineTapped(Lift lift) {
    _showStatusDialog(lift);
  }

  void _showStatusDialog(Lift lift) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Lift Status'),
          content: Text('Do you want to mark this lift as ${lift.isFunctional! ? "inactive" : "active"}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateLiftStatus(lift);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _updateLiftStatus(Lift lift) async {
    lift.isFunctional = !(lift.isFunctional ?? false);
    await liftProvider.update(lift.id!, lift);
    _fetchData();
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
              polylines: _polylines,
            ),
    );
  }
}
