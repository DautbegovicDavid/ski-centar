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
    if (!mounted) return;
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
    final filteredLifts =
        lifts!.result.where((lift) => lift.stateMachine != 'hidden').toList();

    final Set<Marker> markers = filteredLifts.expand((lift) {
      return lift.liftLocations!.map((location) {
        BitmapDescriptor iconColor;
        if (lift.stateMachine == 'draft') {
          iconColor =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
        } else {
          iconColor = (lift.isFunctional ?? false)
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
        }

        return Marker(
          markerId: MarkerId('${lift.name}_${location.id}'),
          position: LatLng(location.locationX!, location.locationY!),
          infoWindow: InfoWindow(title: lift.name, snippet: lift.stateMachine != "active" ? "Under maintenance" : null),
          icon: iconColor,
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
        infoWindow: const InfoWindow(title: "Ski Accident"),
        icon: icon,
      );
    }).toSet();

    Set<Marker> combinedMarkers = combineMarkers(markers, accidentMarkers);

    final Set<Polyline> liftPolylines = filteredLifts.map((lift) {
      Color polylineColor;
      if (lift.stateMachine == 'draft') {
        polylineColor = Colors.orange;
      } else {
        polylineColor =
            (lift.isFunctional ?? false) ? Colors.green : Colors.red;
      }

      return Polyline(
        polylineId: PolylineId('${lift.name}_lift_polyline'),
        points: lift.liftLocations!
            .map((location) => LatLng(location.locationX!, location.locationY!))
            .toList(),
        color: polylineColor,
        width: 5,
      );
    }).toSet();

    final Set<Polyline> trailPolylines = trails!.result.map((trail) {
      return Polyline(
        polylineId: PolylineId('${trail.name}_trail_polyline'),
        points: trail.trailLocations!
            .map((location) => LatLng(location.locationX!, location.locationY!))
            .toList(),
        color: (trail.isFunctional ?? false)
            ? const Color.fromARGB(255, 14, 121, 17)
            : Colors.red,
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
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.warning, color: Colors.white),
                    ),
                  ),
              ],
            ),
    );
  }
}
