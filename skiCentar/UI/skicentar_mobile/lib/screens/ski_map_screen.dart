import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/lift.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/models/ski_accident.dart';
import 'package:skicentar_mobile/models/trail.dart';
import 'package:skicentar_mobile/providers/lift_provider.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/providers/ski_accident_provider.dart';
import 'package:skicentar_mobile/providers/trail_provider.dart';
import 'package:skicentar_mobile/providers/user_provider.dart';
import 'package:skicentar_mobile/screens/report_accident_screen.dart';
import 'package:skicentar_mobile/utils/icons_helper.dart';
import 'package:skicentar_mobile/utils/utils.dart';

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
  late UserProvider userProvider;
  late SkiAccidentProvider skiAccidentsProvider;

  SearchResult<Trail>? trails;
  SearchResult<SkiAccident>? skiAccidents;
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
    userProvider = context.read<UserProvider>();
    skiAccidentsProvider = context.read<SkiAccidentProvider>();
    resortProvider.addListener(_updateInfo);
    userProvider.addListener(_updateScreen);
    _fetchData();
  }

  void _updateInfo() {
    _fetchData();
  }

  void _updateScreen() {
    setState(() {});
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
    skiAccidents = await skiAccidentsProvider.get(filter: {'IsActive': true});
    await _setMarkersAndPolylines();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _setMarkersAndPolylines() async {
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
    Map<String, BitmapDescriptor> categoryIcons = await getCategoryIcons();

    final Set<Marker> accidentMarkers = skiAccidents!.result.where((poi) {
      return poi.locationX != null && poi.locationY != null;
    }).map((poi) {
      BitmapDescriptor icon = categoryIcons['Accidents'] ??
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      return Marker(
        markerId: MarkerId('${poi.id}'),
        position: LatLng(poi.locationX!, poi.locationY!),
        infoWindow: const InfoWindow(title: "Ski accident Active"),
        icon: icon,
      );
    }).toSet();

    Set<Marker> combinedMarkers = combineMarkers(markers, accidentMarkers);

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
        _markers = combinedMarkers;
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

  void _navigateToReportAccidentScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportAccidentScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: resortProvider.selectedResort == null ||
              userProvider.currentUser == null
          ? const Center(child: Text('Please select a resort'))
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 14.0,
                  ),
                  markers: _markers,
                  polylines: _polylines,
                ),
                if (userProvider.currentUser!.hasActiveTicket!)
                  Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    child: FloatingActionButton(
                      onPressed: _navigateToReportAccidentScreen,
                      child: Icon(Icons.warning,
                          color: Colors.white),
                      backgroundColor: Colors.red,
                    ),
                  ),
              ],
            ),
    );
  }
}
