
import 'package:json_annotation/json_annotation.dart';

part 'lift.g.dart';
@JsonSerializable()
class Lift{
  int? id;
  String? name;
  bool? isFunctional;
  
  Lift({this.id,this.name});

  factory Lift.FromJson(Map<String,dynamic> json) => _$LiftFromJson(json);

  Map<String,dynamic> toJson() => _$LiftToJson(this);
}