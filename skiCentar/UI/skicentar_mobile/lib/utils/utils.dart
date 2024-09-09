import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime, {bool startOfDay = false}) {
  if (startOfDay) {
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
  return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dateTime);
}

void showCustomSnackBar(BuildContext context, IconData icon,
    Color backgroundColor, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          )
        ],
      ),
      backgroundColor: backgroundColor,
    ),
  );
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat.yMMMMd().add_jm();
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
