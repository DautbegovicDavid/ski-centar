import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

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

String formatDate(DateTime date) {
  final DateFormat formatter =
      DateFormat.yMMMMd().add_jm();
  return formatter.format(date);
}

Set<Polyline> combinePolylines(Set<Polyline> set1, Set<Polyline> set2) {
  final Set<Polyline> combinedSet = Set<Polyline>.from(set1);
  combinedSet.addAll(set2);
  return combinedSet;
}

Set<Marker> combineMarkers(Set<Marker> set1, Set<Marker> set2) {
  final Set<Marker> combinedSet = Set<Marker>.from(set1);
  combinedSet.addAll(set2);
  return combinedSet;
}
