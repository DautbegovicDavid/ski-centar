// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyWeather _$DailyWeatherFromJson(Map<String, dynamic> json) => DailyWeather(
      id: (json['id'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      resortId: (json['resortId'] as num?)?.toInt(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      precipitation: (json['precipitation'] as num?)?.toDouble(),
      windSpeed: (json['windSpeed'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
      snowHeight: (json['snowHeight'] as num?)?.toDouble(),
      weatherCondition: json['weatherCondition'] as String?,
    )..resort = json['resort'] == null
        ? null
        : Resort.fromJson(json['resort'] as Map<String, dynamic>);

Map<String, dynamic> _$DailyWeatherToJson(DailyWeather instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'resortId': instance.resortId,
      'resort': instance.resort,
      'temperature': instance.temperature,
      'precipitation': instance.precipitation,
      'windSpeed': instance.windSpeed,
      'humidity': instance.humidity,
      'snowHeight': instance.snowHeight,
      'weatherCondition': instance.weatherCondition,
    };
