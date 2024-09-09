import 'dart:async';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

bool _isRendererInitialized = false;

Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null || _isRendererInitialized) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer =
      Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    try {
      await mapsImplementation
          .initializeWithRenderer(AndroidMapRenderer.latest)
          .then((AndroidMapRenderer initializedRenderer) {
        _isRendererInitialized = true;
        completer.complete(initializedRenderer);
      });
    } catch (e) {
      completer.complete(null);
    }
  } else {
    completer.complete(null);
  }

  return completer.future;
}
