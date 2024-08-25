// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_poi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPoi _$UserPoiFromJson(Map<String, dynamic> json) => UserPoi(
      userId: (json['userId'] as num?)?.toInt(),
      poiId: (json['poiId'] as num?)?.toInt(),
      interactionTimestamp: json['interactionTimestamp'] == null
          ? null
          : DateTime.parse(json['interactionTimestamp'] as String),
      interactionType: json['interactionType'] as String?,
    );

Map<String, dynamic> _$UserPoiToJson(UserPoi instance) => <String, dynamic>{
      'interactionType': instance.interactionType,
      'interactionTimestamp': instance.interactionTimestamp?.toIso8601String(),
      'userId': instance.userId,
      'poiId': instance.poiId,
    };
