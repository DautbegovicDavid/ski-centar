// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lift_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiftLocation _$LiftLocationFromJson(Map<String, dynamic> json) => LiftLocation(
      id: (json['id'] as num?)?.toInt(),
      locationX: (json['locationX'] as num?)?.toDouble(),
      locationY: (json['locationY'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LiftLocationToJson(LiftLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'locationX': instance.locationX,
      'locationY': instance.locationY,
    };
