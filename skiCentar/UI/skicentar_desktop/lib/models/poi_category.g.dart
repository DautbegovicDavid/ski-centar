// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poi_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoiCategory _$PoiCategoryFromJson(Map<String, dynamic> json) => PoiCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PoiCategoryToJson(PoiCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
