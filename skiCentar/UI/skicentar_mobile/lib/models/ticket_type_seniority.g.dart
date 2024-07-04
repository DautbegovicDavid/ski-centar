// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_type_seniority.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketTypeSeniority _$TicketTypeSeniorityFromJson(Map<String, dynamic> json) =>
    TicketTypeSeniority(
      id: (json['id'] as num?)?.toInt(),
      seniority: json['seniority'] as String?,
    );

Map<String, dynamic> _$TicketTypeSeniorityToJson(
        TicketTypeSeniority instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seniority': instance.seniority,
    };
