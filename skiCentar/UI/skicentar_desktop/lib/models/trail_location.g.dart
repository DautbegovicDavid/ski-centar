// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trail_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrailLocation _$TrailLocationFromJson(Map<String, dynamic> json) =>
    TrailLocation(
      id: (json['id'] as num?)?.toInt(),
      locationX: (json['locationX'] as num?)?.toDouble(),
      locationY: (json['locationY'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TrailLocationToJson(TrailLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'locationX': instance.locationX,
      'locationY': instance.locationY,
    };
