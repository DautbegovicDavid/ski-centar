import 'package:flutter/material.dart';
import 'package:skicentar_mobile/models/daily_weather.dart';
import 'package:skicentar_mobile/utils/utils.dart';

class DetailedWeatherScreen extends StatelessWidget {
  final DailyWeather weather;
  final Map<String, dynamic> weatherData;

  const DetailedWeatherScreen(
      {Key? key, required this.weather, required this.weatherData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detailed Weather Info'),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Resort Data'),
                    _buildWeatherRow('Last update', formatDate(weather.date!)),
                    _buildWeatherRow(
                        'Condition', weather.weatherCondition.toString()),
                    _buildWeatherRow('Wind Speed', '${weather.windSpeed} km/h'),
                    _buildWeatherRow('Snow Height', '${weather.snowHeight} cm'),
                    _buildWeatherRow('Humidity', '${weather.humidity} %'),
                    _buildWeatherRow(
                        'Precipitation', '${weather.precipitation} mm'),
                    const Divider(),
                    _buildSectionHeader('Live Data'),
                    _buildWeatherRow('Location', weatherData['name']),
                    _buildWeatherRow(
                        'Temperature', '${weatherData['main']['temp']}°C'),
                    _buildWeatherRow('Description',
                        weatherData['weather'][0]['description']),
                    const SizedBox(height: 20),
                    Center(
                      child: Image.network(
                        'http://openweathermap.org/img/wn/${weatherData['weather'][0]['icon']}@2x.png',
                        scale: 0.8,
                      ),
                    ),
                  ],
                ),
              ))),
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
          color: Colors.blueGrey, // Change this to your desired color
        ),
      ),
    );
  }
}
