import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/daily_weather.dart';
import 'package:skicentar_mobile/models/lift.dart';
import 'package:skicentar_mobile/models/point_of_interest.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/models/ticket_type.dart';
import 'package:skicentar_mobile/models/trail.dart';
import 'package:skicentar_mobile/providers/daily_weather_provider.dart';
import 'package:skicentar_mobile/providers/lift_provider.dart';
import 'package:skicentar_mobile/providers/poi_provider.dart';
import 'package:skicentar_mobile/providers/resort_provider.dart';
import 'package:skicentar_mobile/providers/ticket_type_provider.dart';
import 'package:skicentar_mobile/providers/trail_provider.dart';
import 'package:skicentar_mobile/providers/user_provider.dart';
import 'package:skicentar_mobile/providers/weather_provider.dart';
import 'package:skicentar_mobile/screens/detailed_ski_lifts_screen.dart';
import 'package:skicentar_mobile/screens/detailed_ski_tracks_screen.dart';
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
  late LiftProvider liftProvider;
  late TrailProvider trailProvider;
  late ResortProvider resortProvider;
  late WeatherProvider weatherProvider;
  late PoiProvider userPoiProvider;
  late UserProvider userProvider;

  SearchResult<DailyWeather>? weatherResult;
  SearchResult<TicketType>? ticketsResult;
  SearchResult<Trail>? trailResult;
  SearchResult<Lift>? liftResult;
  List<PointOfInterest>? userRecommendedPois;

  Map<String, dynamic>? _weatherData;

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    dailyWeatherProvider = context.read<DailyWeatherProvider>();
    weatherProvider = context.read<WeatherProvider>();
    ticketsProvider = context.read<TicketTypeProvider>();
    liftProvider = context.read<LiftProvider>();
    trailProvider = context.read<TrailProvider>();
    resortProvider = context.read<ResortProvider>();
    userPoiProvider = context.read<PoiProvider>();
    resortProvider.addListener(_updateInfo);
    _fetchData();
  }

  @override
  void dispose() {
    resortProvider.removeListener(_updateInfo);
    super.dispose();
  }

  void _updateInfo() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    final resortId = resortProvider.selectedResort?.id;
    if (resortId == null) return;

    try {
      final results = await Future.wait([
        dailyWeatherProvider.get(filter: {'ResortId': resortId}),
        ticketsProvider.get(filter: {'resortId': resortId}),
        userPoiProvider.getRecommendedPois(userProvider.currentUser!.id!),
        trailProvider
            .get(filter: {'resortId': resortId, 'IsDifficultyIncluded': true}),
        liftProvider
            .get(filter: {'IsLiftTypeIncluded': true, 'resortId': resortId}),
        _fetchWeather(),
      ]);

      weatherResult = results[0] as SearchResult<DailyWeather>?;
      ticketsResult = results[1] as SearchResult<TicketType>?;
      userRecommendedPois = results[2] as List<PointOfInterest>?;
      trailResult = results[3] as SearchResult<Trail>?;
      liftResult = results[4] as SearchResult<Lift>?;

      setState(() {
        loaded = true;
      });
    } catch (e) {
      setState(() {
        loaded = false;
      });
    }
  }

  Future<void> _fetchWeather() async {
    if (resortProvider.selectedResort != null) {
      try {
        final data = await weatherProvider.fetchWeather(
            resortProvider.selectedResort!.name!,
            resortProvider.selectedResort!.location!);
        setState(() {
          _weatherData = data;
        });
      } catch (e) {
        throw Exception('Error fetching weather: $e');
      }
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
                title: 'TOP LOCATIONS',
                icon: Icons.place,
                content: _buildPOISection(),
                seeMore: false),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
      {required String title,
      required IconData icon,
      required Widget content,
      VoidCallback? onPressed,
      required bool seeMore}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(title, icon, onPressed, seeMore: seeMore),
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
      String title, IconData icon, VoidCallback? onPressed,
      {bool seeMore = true}) {
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
        if (seeMore)
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
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Text(
            weather.weatherCondition?.toString() ?? 'N/A',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Text(
            "Wind Speed: ${weather.windSpeed?.toString() ?? 'N/A'}  km/h",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
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
            builder: (context) => const PaymentScreen(),
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
    if (userRecommendedPois == null) {
      return const CircularProgressIndicator();
    }

    final pois = userRecommendedPois!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pois.map((poi) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
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
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Text(
            'Number of opened lifts: $workingLifts',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Text(
            'Number of closed lifts: $nonWorkingLifts',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
