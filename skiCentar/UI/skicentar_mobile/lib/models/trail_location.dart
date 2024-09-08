
import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_mobile/models/location.dart';

part 'trail_location.g.dart';

@JsonSerializable()

class TrailLocation implements Location{
  int? id;
  @override
  double? locationX;
  @override
  double? locationY;

  TrailLocation({this.id,this.locationX,this.locationY});

  factory TrailLocation.fromJson(Map<String,dynamic> json) => _$TrailLocationFromJson(json);

  @override
  Map<String,dynamic> toJson() => _$TrailLocationToJson(this);
}