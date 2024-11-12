
import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_mobile/models/ticket.dart';

part 'ticket_purchase.g.dart';

@JsonSerializable()
class TicketPurchase{
  int? id;
  int? userId;
  int? ticketId;
  double? totalPrice;
  DateTime? purchaseDate;
  Ticket? ticket;

  TicketPurchase({this.id,this.userId,this.ticketId});

  factory TicketPurchase.fromJson(Map<String,dynamic> json) => _$TicketPurchaseFromJson(json);

  Map<String,dynamic> toJson() => _$TicketPurchaseToJson(this);
}