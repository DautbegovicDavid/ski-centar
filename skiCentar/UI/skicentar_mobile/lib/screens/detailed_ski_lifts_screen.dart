import 'package:flutter/material.dart';
import 'package:skicentar_mobile/models/lift.dart';

class DetailedSkiLiftsScreen extends StatelessWidget {
  final List<Lift> lifts;

  const DetailedSkiLiftsScreen({Key? key, required this.lifts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final functionalLifts = lifts.where((lift) => lift.isFunctional!).toList();
    final nonFunctionalLifts =
        lifts.where((lift) => !lift.isFunctional!).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ski Lifts Info'),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionHeader('Functional Lifts - ${functionalLifts.length}'),
            _buildLiftsList(functionalLifts),
            _buildSectionHeader('Non-Functional Lifts - ${nonFunctionalLifts.length}'),
            _buildLiftsList(nonFunctionalLifts),
          ],
        ),
      ),
    );
  }

  Widget _buildLiftsList(List<Lift> lifts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lifts.map((lift) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lift.name ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                _buildRow('Capacity', lift.capacity.toString(),
                    Icons.people_outline_outlined),
                _buildRow('Length', '${lift.liftType!.name ?? 0}', null),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRow(String label, String value, IconData? icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
              if (icon != null) ...[
                const SizedBox(
                    width: 4), // Add some spacing between text and icon
                Icon(icon, size: 24),
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey, // Change this to your desired color
        ),
      ),
    );
  }
}
