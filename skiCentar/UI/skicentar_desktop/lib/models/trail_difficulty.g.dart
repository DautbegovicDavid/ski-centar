// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trail_difficulty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrailDifficulty _$TrailDifficultyFromJson(Map<String, dynamic> json) =>
    TrailDifficulty(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$TrailDifficultyToJson(TrailDifficulty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
    };
