import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/daily_weather.dart';
import 'package:skicentar_mobile/models/lift.dart';
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
import 'package:skicentar_mobile/providers/weather_provider.dart';
import 'package:skicentar_mobile/screens/detailed_ski_tracks_screen.dart';
import 'package:skicentar_mobile/screens/detailed_ski_lifts_screen.dart';
import 'package:skicentar_mobile/screens/detailed_weather_screen.dart';
import 'package:skicentar_mobile/screens/payment_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DailyWeatherProvider dailyWeatherProvider;
  late TicketTypeProvider ticketsProvider;
  late PoiCategoryProvider poiProvider;
  late LiftProvider liftProvider;
  late TrailProvider trailProvider;
  late ResortProvider resortProvider;
  late WeatherProvider weatherProvider;

  SearchResult<DailyWeather>? weatherResult;
  SearchResult<TicketType>? ticketsResult;
  SearchResult<PoiCategory>? poiResult;
  SearchResult<Trail>? trailResult;
  SearchResult<Lift>? liftResult;

  Map<String, dynamic>? _weatherData;

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    dailyWeatherProvider = context.read<DailyWeatherProvider>();
    weatherProvider = context.read<WeatherProvider>();
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
    weatherResult = await dailyWeatherProvider
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
      'IsDifficultyIncluded': true
    });
    liftResult = await liftProvider.get(filter: {
      'IsLiftTypeIncluded': true,
      'resortId': resortProvider.selectedResort?.id,
    });
    await _fetchWeather();
    loaded = true;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _fetchWeather() async {
    try {
      final data = await weatherProvider.fetchWeather(
          resortProvider.selectedResort!.name!,
          resortProvider.selectedResort!.location!);
      setState(() {
        _weatherData = data;
      });
    } catch (e) {
      print('Error fetching weather: $e');
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
            if (loaded)
              _buildCard(
                _buildWeatherSection(),
              ),
            _buildCard(
              _buildSkiTracksSection(),
            ),
            _buildCard(
              _buildSkiLiftsSection(),
            ),
            _buildCard(
              _buildSkiTicketsSection(),
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
      required Widget content,
      VoidCallback? onPressed}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(title, icon, onPressed),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Widget content) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, IconData icon, VoidCallback? onPressed) {
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
          onPressed: onPressed,
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
        _buildSectionHeader(
          'Weather',
          Icons.sunny,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailedWeatherScreen(
                weather: weather,
                weatherData: _weatherData!,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 2.0),
          child: Text(
            weather.weatherCondition?.toString() ?? 'N/A',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 2.0),
          child: Text(
            "Wind Speed: ${weather.windSpeed?.toString() ?? 'N/A'}  km/h",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 2.0),
          child: Text(
            "Snow Height: ${weather.snowHeight?.toString() ?? 'N/A'} cm",
            style: const TextStyle(fontSize: 16),
          ),
        ),
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

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildSectionHeader(
        'Ski tickets',
        Icons.confirmation_num_rounded,
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(),
          ),
        ),
      ),
      ...groupedTickets.entries.map((entry) {
        return Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Text("${entry.key}: ${entry.value.join('/')}KM",
                style: const TextStyle(fontSize: 16)));
      }).toList(),
    ]);
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
              const EdgeInsets.only(bottom: 2.0),
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
        _buildSectionHeader(
          'Ski Tracks: ${resortProvider.selectedResort?.skiWorkHours}',
          Icons.snowboarding,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailedSkiTracksScreen(trails: trails),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 2.0), // Add padding between items
          child: Text(
            'Number of opened tracks: $workingTracks',
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

  Widget _buildSkiLiftsSection() {
    if (trailResult == null) {
      return const CircularProgressIndicator();
    }

    final lifts = liftResult!.result;

    if (liftResult!.result.isEmpty) {
      return const Center(child: Text("No data"));
    }

    final workingLifts =
        lifts.where((lift) => lift.isFunctional == true).length;
    final nonWorkingLifts = lifts.length - workingLifts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Ski Lifts: ${resortProvider.selectedResort?.skiWorkHours}',
          Icons.elevator,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailedSkiLiftsScreen(lifts: lifts),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 2.0), // Add padding between items
          child: Text(
            'Number of opened lifts: $workingLifts',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 2.0), // Add padding between items
          child: Text(
            'Number of closed lifts: $nonWorkingLifts',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
