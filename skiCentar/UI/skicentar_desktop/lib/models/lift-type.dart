
import 'package:json_annotation/json_annotation.dart';

part 'lift-type.g.dart';
@JsonSerializable()
class LiftType{
  int? id;
  String? name;
  
  LiftType({this.id,this.name});

  factory LiftType.fromJson(Map<String,dynamic> json) => _$LiftTypeFromJson(json);

  Map<String,dynamic> toJson() => _$LiftTypeToJson(this);
}