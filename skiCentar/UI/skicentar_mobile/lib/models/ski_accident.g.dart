// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ski_accident.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkiAccident _$SkiAccidentFromJson(Map<String, dynamic> json) => SkiAccident(
      id: (json['id'] as num?)?.toInt(),
      locationX: (json['locationX'] as num?)?.toDouble(),
      locationY: (json['locationY'] as num?)?.toDouble(),
    )
      ..description = json['description'] as String?
      ..isActive = json['isActive'] as bool?
      ..isReporterInjured = json['isReporterInjured'] as bool?
      ..userId = (json['userId'] as num?)?.toInt()
      ..trailId = (json['trailId'] as num?)?.toInt()
      ..peopleInvolved = (json['peopleInvolved'] as num?)?.toInt()
      ..timeStamp = json['timeStamp'] == null
          ? null
          : DateTime.parse(json['timeStamp'] as String)
      ..trail = json['trail'] == null
          ? null
          : Trail.fromJson(json['trail'] as Map<String, dynamic>)
      ..user = json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$SkiAccidentToJson(SkiAccident instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'isActive': instance.isActive,
      'isReporterInjured': instance.isReporterInjured,
      'userId': instance.userId,
      'trailId': instance.trailId,
      'peopleInvolved': instance.peopleInvolved,
      'locationX': instance.locationX,
      'locationY': instance.locationY,
      'timeStamp': instance.timeStamp?.toIso8601String(),
      'trail': instance.trail,
      'user': instance.user,
    };
