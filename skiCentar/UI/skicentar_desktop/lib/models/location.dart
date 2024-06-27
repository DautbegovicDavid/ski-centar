
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';
@JsonSerializable()
class Location{
  double? locationX;
  double? locationY;

  Location({this.locationX,this.locationY});

  factory Location.fromJson(Map<String,dynamic> json) => _$LocationFromJson(json);

  Map<String,dynamic> toJson() => _$LocationToJson(this);
}