// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_of_interest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointOfInterest _$PointOfInterestFromJson(Map<String, dynamic> json) =>
    PointOfInterest(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      resortId: (json['resortId'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
      locationX: (json['locationX'] as num?)?.toDouble(),
      locationY: (json['locationY'] as num?)?.toDouble(),
    )
      ..resort = json['resort'] == null
          ? null
          : Resort.fromJson(json['resort'] as Map<String, dynamic>)
      ..category = json['category'] == null
          ? null
          : PoiCategory.fromJson(json['category'] as Map<String, dynamic>)
      ..description = json['description'] as String?;

Map<String, dynamic> _$PointOfInterestToJson(PointOfInterest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'resortId': instance.resortId,
      'resort': instance.resort,
      'categoryId': instance.categoryId,
      'category': instance.category,
      'locationX': instance.locationX,
      'locationY': instance.locationY,
      'description': instance.description,
    };
