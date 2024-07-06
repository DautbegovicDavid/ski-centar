import 'package:flutter/material.dart';
import 'package:skicentar_mobile/models/trail.dart';

class DetailedSkiTracksScreen extends StatelessWidget {
  final List<Trail> trails;

  const DetailedSkiTracksScreen({Key? key, required this.trails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final functionalTrails = trails.where((trail) => trail.isFunctional!).toList();
    final nonFunctionalTrails = trails.where((trail) => !trail.isFunctional!).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ski Tracks Info'),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionHeader('Functional Trails - ${functionalTrails.length}'),
            _buildTrailsList(functionalTrails),
            _buildSectionHeader('Non-Functional Trails - ${nonFunctionalTrails.length}'),
            _buildTrailsList(nonFunctionalTrails),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailsList(List<Trail> trails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: trails.map((trail) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trail.name ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                _buildWeatherRow('Difficulty', trail.difficulty?.name ?? 'Unknown'),
                _buildWeatherRow('Length', '${trail.length ?? 0} m'),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWeatherRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
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
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
