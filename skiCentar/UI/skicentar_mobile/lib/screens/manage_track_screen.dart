import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/models/trail.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/providers/trail_provider.dart';

class ManageTracksScreen extends StatefulWidget {
  @override
  State<ManageTracksScreen> createState() => _ManageTracksScreenState();
}

class _ManageTracksScreenState extends State<ManageTracksScreen> {
  late GoogleMapController mapController;

  LatLng _center =
      const LatLng(43.820, 18.313); //Sarajevo

  late TrailProvider trailProvider;
  late ResortProvider resortProvider;

  SearchResult<Trail>? trails;

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  bool mapLoaded = false;

  @override
  void initState() {
    super.initState();
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
    final Set<Marker> markers = trails!.result.expand((trail) {
      return trail.trailLocations!.map((location) {
        return Marker(
          markerId: MarkerId('${trail.name}_${location.id}'),
          position: LatLng(location.locationX!, location.locationY!),
          infoWindow: InfoWindow(title: trail.name),
          icon: (trail.isFunctional ?? false)
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () => _onMarkerTapped(trail),
        );
      });
    }).toSet();

    final Set<Polyline> liftPolylines = trails!.result.map((trail) {
      return Polyline(
        polylineId: PolylineId('${trail.name}_polyline'),
        points: trail.trailLocations!
            .map((location) => LatLng(location.locationX!, location.locationY!))
            .toList(),
        color: (trail.isFunctional ?? false) ? Colors.green : Colors.red,
        width: 5,
        onTap: () => _onPolylineTapped(trail),
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

  void _onMarkerTapped(Trail trail) {
    _showStatusDialog(trail);
  }

  void _onPolylineTapped(Trail trail) {
    _showStatusDialog(trail);
  }

  void _showStatusDialog(Trail trail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Trail Status'),
          content: Text('Do you want to mark this trail as ${trail.isFunctional! ? "inactive" : "active"}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateTrailStatus(trail);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _updateTrailStatus(Trail trail) async {
    trail.isFunctional = !(trail.isFunctional ?? false);
    await trailProvider.update(trail.id!, trail);
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
