// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trail _$TrailFromJson(Map<String, dynamic> json) => Trail(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    )
      ..isFunctional = json['isFunctional'] as bool?
      ..difficultyId = (json['difficultyId'] as num?)?.toInt()
      ..resortId = (json['resortId'] as num?)?.toInt()
      ..resort = json['resort'] == null
          ? null
          : Resort.fromJson(json['resort'] as Map<String, dynamic>)
      ..length = (json['length'] as num?)?.toDouble()
      ..difficulty = json['difficulty'] == null
          ? null
          : TrailDifficulty.fromJson(json['difficulty'] as Map<String, dynamic>)
      ..trailLocations = (json['trailLocations'] as List<dynamic>?)
          ?.map((e) => TrailLocation.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TrailToJson(Trail instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isFunctional': instance.isFunctional,
      'difficultyId': instance.difficultyId,
      'resortId': instance.resortId,
      'resort': instance.resort,
      'length': instance.length,
      'difficulty': instance.difficulty,
      'trailLocations': instance.trailLocations,
    };
