// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketPurchase _$TicketPurchaseFromJson(Map<String, dynamic> json) =>
    TicketPurchase(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      ticketId: (json['ticketId'] as num?)?.toInt(),
    )
      ..totalPrice = (json['totalPrice'] as num?)?.toDouble()
      ..purchaseDate = json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String)
      ..ticket = json['ticket'] == null
          ? null
          : Ticket.fromJson(json['ticket'] as Map<String, dynamic>);

Map<String, dynamic> _$TicketPurchaseToJson(TicketPurchase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'ticketId': instance.ticketId,
      'totalPrice': instance.totalPrice,
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
      'ticket': instance.ticket,
    };
