import 'package:flutter/material.dart';
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
