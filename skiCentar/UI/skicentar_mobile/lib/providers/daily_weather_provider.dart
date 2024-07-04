// import 'package:skicentar_desktop/models/daily_weather.dart';
// import 'package:skicentar_desktop/providers/base_provider.dart';

import 'package:skicentar_mobile/models/daily_weather.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';

class DailyWeatherProvider extends BaseProvider<DailyWeather> {
  DailyWeatherProvider(): super("DailyWeather");

  @override
  DailyWeather fromJson(data) {
    return DailyWeather.fromJson(data);
  }
}