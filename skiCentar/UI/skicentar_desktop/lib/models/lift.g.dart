// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lift _$LiftFromJson(Map<String, dynamic> json) => Lift(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    )
      ..isFunctional = json['isFunctional'] as bool?
      ..stateMachine = json['stateMachine'] as String?
      ..capacity = (json['capacity'] as num?)?.toInt()
      ..liftTypeId = (json['liftTypeId'] as num?)?.toInt()
      ..resortId = (json['resortId'] as num?)?.toInt()
      ..resort = json['resort'] == null
          ? null
          : Resort.fromJson(json['resort'] as Map<String, dynamic>)
      ..liftType = json['liftType'] == null
          ? null
          : LiftType.fromJson(json['liftType'] as Map<String, dynamic>)
      ..liftLocations = (json['liftLocations'] as List<dynamic>?)
          ?.map((e) => LiftLocation.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$LiftToJson(Lift instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isFunctional': instance.isFunctional,
      'stateMachine': instance.stateMachine,
      'capacity': instance.capacity,
      'liftTypeId': instance.liftTypeId,
      'resortId': instance.resortId,
      'resort': instance.resort,
      'liftType': instance.liftType,
      'liftLocations': instance.liftLocations,
    };
