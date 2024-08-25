import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getBitmapDescriptorFromIconData(
  IconData iconData, {
  Color color = Colors.black,
  double size = 70,
}) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final TextPainter textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );
  final TextSpan textSpan = TextSpan(
    text: String.fromCharCode(iconData.codePoint),
    style: TextStyle(
      fontSize: size,
      fontFamily: iconData.fontFamily,
      color: color,
    ),
  );
  textPainter.text = textSpan;
  textPainter.layout();
  textPainter.paint(
    canvas,
    Offset.zero,
  );
  final ui.Image image = await pictureRecorder.endRecording().toImage(
        size.toInt(),
        size.toInt(),
      );
  final ByteData? byteData = await image.toByteData(
    format: ui.ImageByteFormat.png,
  );
  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Future<Map<String, BitmapDescriptor>> getCategoryIcons() async {
  return {
    'Restaurant': await getBitmapDescriptorFromIconData(Icons.restaurant,
        color: Colors.red, size: 80),
    'Bar': await getBitmapDescriptorFromIconData(Icons.local_bar,
        color: Colors.purple, size: 80),
    'Coffee & Tea': await getBitmapDescriptorFromIconData(Icons.coffee,
        color: Colors.brown, size: 80),
    'Parking': await getBitmapDescriptorFromIconData(
        Icons.local_parking_outlined,
        color: Colors.blue,
        size: 80),
    'Hotel': await getBitmapDescriptorFromIconData(Icons.hotel,
        color: Colors.indigo, size: 80),
    'Info': await getBitmapDescriptorFromIconData(Icons.info,
        color: Colors.green, size: 80),
    'Medical': await getBitmapDescriptorFromIconData(
        Icons.medical_services_rounded,
        color: Colors.red,
        size: 80),
    'Accidents': await getBitmapDescriptorFromIconData(Icons.emergency_sharp,
        color: Colors.red, size: 80),
    'Ski School': await getBitmapDescriptorFromIconData(Icons.school,
        color: Colors.orange, size: 80),
    'Ski Rent': await getBitmapDescriptorFromIconData(Icons.snowboarding,
        color: Colors.teal, size: 80),
  };
}
