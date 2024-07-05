
import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_mobile/models/ticket_type.dart';

part 'ticket.g.dart';
@JsonSerializable()
class Ticket{
  int? id;
  int? ticketTypeId;
  bool? active;
  double? totalPrice;
  TicketType? ticketType;
  String? description;
  DateTime? validFrom;
  DateTime? validTo;

  Ticket({this.id,this.ticketTypeId,this.totalPrice,this.validFrom,this.validTo});

  factory Ticket.fromJson(Map<String,dynamic> json) => _$TicketFromJson(json);

  Map<String,dynamic> toJson() => _$TicketToJson(this);
}