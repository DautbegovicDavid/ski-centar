
import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_desktop/models/ticket_type_seniority.dart';

part 'ticket_type.g.dart';
@JsonSerializable()
class TicketType{
  int? id;
  bool? fullDay;
  double? price;
  TicketTypeSeniority? ticketTypeSeniority;
  int? ticketTypeSeniorityId;
  
  TicketType({this.id,this.fullDay,this.price,this.ticketTypeSeniorityId});

  factory TicketType.fromJson(Map<String,dynamic> json) => _$TicketTypeFromJson(json);

  Map<String,dynamic> toJson() => _$TicketTypeToJson(this);
}