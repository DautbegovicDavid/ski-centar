
import 'package:json_annotation/json_annotation.dart';

part 'ticket_type_seniority.g.dart';
@JsonSerializable()
class TicketTypeSeniority{
  int? id;
  String? seniority;
  
  TicketTypeSeniority({this.id,this.seniority});

  factory TicketTypeSeniority.fromJson(Map<String,dynamic> json) => _$TicketTypeSeniorityFromJson(json);

  Map<String,dynamic> toJson() => _$TicketTypeSeniorityToJson(this);
}