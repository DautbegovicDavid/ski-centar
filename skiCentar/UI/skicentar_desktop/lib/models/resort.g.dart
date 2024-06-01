// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resort _$ResortFromJson(Map<String, dynamic> json) => Resort(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    )
      ..location = json['location'] as String?
      ..elevation = (json['elevation'] as num?)?.toInt()
      ..skiWorkHours = json['skiWorkHours'] as String?;

Map<String, dynamic> _$ResortToJson(Resort instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'elevation': instance.elevation,
      'skiWorkHours': instance.skiWorkHours,
    };
