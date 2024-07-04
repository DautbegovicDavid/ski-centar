import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/daily_weather.dart';
import 'package:skicentar_mobile/models/poi_category.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/models/ticket_type.dart';
import 'package:skicentar_mobile/models/trail.dart';
import 'package:skicentar_mobile/providers/daily_weather_provider.dart';
import 'package:skicentar_mobile/providers/lift_provider.dart';
import 'package:skicentar_mobile/providers/poi_category_provider.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/providers/ticket_type_provider.dart';
import 'package:skicentar_mobile/providers/trail_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DailyWeatherProvider weatherProvider;
  late TicketTypeProvider ticketsProvider;
  late PoiCategoryProvider poiProvider;
  late LiftProvider liftProvider;
  late TrailProvider trailProvider;
  late ResortProvider resortProvider;

  SearchResult<DailyWeather>? weatherResult;
  SearchResult<TicketType>? ticketsResult;
  SearchResult<PoiCategory>? poiResult;
  SearchResult<Trail>? trailResult;

  @override
  void initState() {
    super.initState();
    weatherProvider = context.read<DailyWeatherProvider>();
    ticketsProvider = context.read<TicketTypeProvider>();
    liftProvider = context.read<LiftProvider>();
    poiProvider = context.read<PoiCategoryProvider>();
    trailProvider = context.read<TrailProvider>();
    resortProvider = context.read<ResortProvider>();
    resortProvider.addListener(_updateInfo);
    _fetchData();
  }

  void _updateInfo() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    weatherResult = await weatherProvider
        .get(filter: {'ResortId': resortProvider.selectedResort?.id});
    ticketsResult = await ticketsProvider.get(filter: {
      'resortId': resortProvider.selectedResort?.id,
    });
    poiResult = await poiProvider.get(filter: {
      'isResortIncluded': true,
      'isCategoryIncluded': true,
      'resortId': resortProvider.selectedResort?.id,
    });
    trailResult = await trailProvider.get(filter: {
      'resortId': resortProvider.selectedResort?.id,
    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionCard(
              title: 'Weather',
              icon: Icons.wb_sunny,
              content: _buildWeatherSection(),
            ),
            _buildSectionCard(
              title: 'Ski Tracks: ${resortProvider.selectedResort?.skiWorkHours}',
              icon: Icons.snowboarding,
              content: _buildSkiTracksSection(),
            ),
            _buildSectionCard(
              title: 'Ski tickets',
              icon: Icons.confirmation_number,
              content: _buildSkiTicketsSection(),
            ),
            _buildSectionCard(
              title: 'POI',
              icon: Icons.place,
              content: _buildPOISection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
      {required String title,
      required IconData icon,
      required Widget content}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(title, icon),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            // Handle "See more" tap
          },
          child: const Text('See more'),
        ),
      ],
    );
  }

  Widget _buildWeatherSection() {
    if (weatherResult == null) {
      return const CircularProgressIndicator();
    }
    if (weatherResult!.result.isEmpty) {
      return const Center(child: Text("No recent data"));
    }
    final weather = weatherResult!.result[0];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(weather.weatherCondition.toString()),
        Text("Wind Speed: ${weather.windSpeed.toString()}  km/h"),
        Text("Snow Height: ${weather.snowHeight.toString()} cm"),
      ],
    );
  }

  Widget _buildSkiTicketsSection() {
    if (ticketsResult == null) {
      return const CircularProgressIndicator();
    }

    final tickets = ticketsResult!.result;

    if (ticketsResult!.result.isEmpty) {
      return const Center(child: Text("No data"));
    }

    final Map<String, List<double>> groupedTickets = {};
    for (var ticket in tickets) {
      final seniority = ticket.ticketTypeSeniority!.seniority.toString();
      if (!groupedTickets.containsKey(seniority)) {
        groupedTickets[seniority] = [];
      }
      groupedTickets[seniority]!.add(ticket.price!);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedTickets.entries.map((entry) {
        return Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Text("${entry.key}: ${entry.value.join('/')}KM",
                style: const TextStyle(fontSize: 16)));
      }).toList(),
    );
  }

  Widget _buildPOISection() {
    if (poiResult == null) {
      return const CircularProgressIndicator();
    }

    final pois = poiResult!.result;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pois.map((poi) {
        return Padding(
          padding:
              const EdgeInsets.only(bottom: 2.0), // Add padding between items
          child: Text(
            poi.name.toString(),
            style: const TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSkiTracksSection() {
    if (trailResult == null) {
      return const CircularProgressIndicator();
    }

    final trails = trailResult!.result;

    if (trailResult!.result.isEmpty) {
      return const Center(child: Text("No data"));
    }

    final workingTracks =
        trails.where((trail) => trail.isFunctional == true).length;
    final nonWorkingTracks = trails.length - workingTracks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(bottom: 2.0), // Add padding between items
          child: Text(
            'Number of open tracks: $workingTracks',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 2.0), // Add padding between items
          child: Text(
            'Number of closed tracks: $nonWorkingTracks',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
