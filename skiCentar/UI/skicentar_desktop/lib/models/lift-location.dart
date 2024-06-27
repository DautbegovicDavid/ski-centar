
import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_desktop/models/location.dart';

part 'lift-location.g.dart';
@JsonSerializable()
class LiftLocation implements Location{
  int? id;
  double? locationX;
  double? locationY;

  LiftLocation({this.id,this.locationX,this.locationY});

  factory LiftLocation.fromJson(Map<String,dynamic> json) => _$LiftLocationFromJson(json);

  Map<String,dynamic> toJson() => _$LiftLocationToJson(this);
}