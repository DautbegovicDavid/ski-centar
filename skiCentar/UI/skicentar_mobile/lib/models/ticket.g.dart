// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      id: (json['id'] as num?)?.toInt(),
      ticketTypeId: (json['ticketTypeId'] as num?)?.toInt(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      validFrom: json['validFrom'] == null
          ? null
          : DateTime.parse(json['validFrom'] as String),
      validTo: json['validTo'] == null
          ? null
          : DateTime.parse(json['validTo'] as String),
    )
      ..active = json['active'] as bool?
      ..ticketType = json['ticketType'] == null
          ? null
          : TicketType.fromJson(json['ticketType'] as Map<String, dynamic>)
      ..description = json['description'] as String?;

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'ticketTypeId': instance.ticketTypeId,
      'active': instance.active,
      'totalPrice': instance.totalPrice,
      'ticketType': instance.ticketType,
      'description': instance.description,
      'validFrom': instance.validFrom?.toIso8601String(),
      'validTo': instance.validTo?.toIso8601String(),
    };
