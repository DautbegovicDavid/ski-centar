
import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_mobile/models/lift-location.dart';
import 'package:skicentar_mobile/models/lift-type.dart';
import 'package:skicentar_mobile/models/resort.dart';

part 'lift.g.dart';
@JsonSerializable()
class Lift{
  int? id;
  String? name;
  bool? isFunctional;
  String? stateMachine;
  int? capacity;
  int? liftTypeId;
  int? resortId;
  Resort? resort;
  LiftType? liftType;
  List<LiftLocation>? liftLocations;
  
  Lift({this.id,this.name});

  factory Lift.fromJson(Map<String,dynamic> json) => _$LiftFromJson(json);

  Map<String,dynamic> toJson() => _$LiftToJson(this);
}