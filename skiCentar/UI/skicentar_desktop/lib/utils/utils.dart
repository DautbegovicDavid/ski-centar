import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlng/latlng.dart';

import '../models/location.dart';

double clamp(double x, double min, double max) {
  if (x < min) x = min;
  if (x > max) x = max;

  return x;
}

List<LatLng> convertToLatLng(List<Location> data) {
  return data.map((location) {
    final latitude = Angle.degree(location.locationX ?? 0.0);
    final longitude = Angle.degree(location.locationY ?? 0.0);
    return LatLng(latitude, longitude);
  }).toList();
}

String formatDateTime(DateTime dateTime) {
  return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dateTime);
}

void showCustomSnackBar(BuildContext context, IconData icon,
    Color backgroundColor, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white), // Icon with white color
          const SizedBox(width: 8),
          Text(
            message,
            style: const TextStyle(color: Colors.white), // Text color
          ),
        ],
      ),
      backgroundColor: backgroundColor, // Background color
    ),
  );
}
