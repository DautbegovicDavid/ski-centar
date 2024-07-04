// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketType _$TicketTypeFromJson(Map<String, dynamic> json) => TicketType(
      id: (json['id'] as num?)?.toInt(),
      fullDay: json['fullDay'] as bool?,
      price: (json['price'] as num?)?.toDouble(),
      ticketTypeSeniorityId: (json['ticketTypeSeniorityId'] as num?)?.toInt(),
      resortId: (json['resortId'] as num?)?.toInt(),
    )
      ..ticketTypeSeniority = json['ticketTypeSeniority'] == null
          ? null
          : TicketTypeSeniority.fromJson(
              json['ticketTypeSeniority'] as Map<String, dynamic>)
      ..resort = json['resort'] == null
          ? null
          : Resort.fromJson(json['resort'] as Map<String, dynamic>);

Map<String, dynamic> _$TicketTypeToJson(TicketType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullDay': instance.fullDay,
      'price': instance.price,
      'ticketTypeSeniority': instance.ticketTypeSeniority,
      'resort': instance.resort,
      'ticketTypeSeniorityId': instance.ticketTypeSeniorityId,
      'resortId': instance.resortId,
    };
