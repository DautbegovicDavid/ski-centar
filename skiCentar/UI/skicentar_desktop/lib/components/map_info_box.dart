import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final int markersAdded;
  final int maxMarkers;
  final String message;

  const InfoBox({
    Key? key,
    required this.markersAdded,
    required this.message,
    this.maxMarkers = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(top: 8.0),
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Markers added: $markersAdded/$maxMarkers',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
