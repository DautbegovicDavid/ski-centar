// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lift _$LiftFromJson(Map<String, dynamic> json) => Lift(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    )..isFunctional = json['isFunctional'] as bool?;

Map<String, dynamic> _$LiftToJson(Lift instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isFunctional': instance.isFunctional,
    };
