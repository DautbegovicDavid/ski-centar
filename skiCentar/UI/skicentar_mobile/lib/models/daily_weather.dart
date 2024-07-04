import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_mobile/models/resort.dart';

part 'daily_weather.g.dart';

@JsonSerializable()
class DailyWeather {
  int? id;
  DateTime? date;
  int? resortId;
  Resort? resort;
  double? temperature;
  double? precipitation;
  double? windSpeed;
  double? humidity;
  double? snowHeight;
  String? weatherCondition;

  DailyWeather({this.id, this.date,this.resortId,this.temperature,this.precipitation,this.windSpeed,this.humidity,this.snowHeight,this.weatherCondition});

  factory DailyWeather.fromJson(Map<String,dynamic> json) => _$DailyWeatherFromJson(json);

  Map<String,dynamic> toJson() => _$DailyWeatherToJson(this);
}
