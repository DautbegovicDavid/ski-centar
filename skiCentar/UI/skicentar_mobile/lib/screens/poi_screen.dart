import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/point_of_interest.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/models/user.dart';
import 'package:skicentar_mobile/models/user_poi.dart';
import 'package:skicentar_mobile/providers/poi_provider.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/providers/user_poi_provider.dart';
import 'package:skicentar_mobile/providers/user_provider.dart';
import 'package:skicentar_mobile/utils/icons_helper.dart';

class PoiScreen extends StatefulWidget {
  const PoiScreen({super.key});

  @override
  State<PoiScreen> createState() => _PoiScreenState();
}

class _PoiScreenState extends State<PoiScreen> {
  late GoogleMapController mapController;

  LatLng _center = const LatLng(43.820, 18.313);

  User? user;
  late PoiProvider poiProvider;
  late ResortProvider resortProvider;
  late UserPoiProvider userPoiProvider;
  late UserProvider userProvider;

  SearchResult<PointOfInterest>? pois;

  Set<Marker> _markers = {};

  bool mapLoaded = false;

  @override
  void initState() {
    super.initState();
    poiProvider = context.read<PoiProvider>();
    resortProvider = context.read<ResortProvider>();
    userPoiProvider = context.read<UserPoiProvider>();
    userProvider = context.read<UserProvider>();

    resortProvider.addListener(_updateInfo);
    _fetchData();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final fetchedUser = await userProvider.getDetails();
      setState(() {
        user = fetchedUser;
        userProvider.setUser(fetchedUser);
      });
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
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
        onTap: () => _onMarkerTapped(poi),
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

  void _onMarkerTapped(PointOfInterest poi) async {
    UserPoi userPoi = UserPoi(
      userId: user!.id!,
      poiId: poi.id,
      interactionType: 'view',
      interactionTimestamp: DateTime.now(),
    );
    await userPoiProvider.insert(userPoi);
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
