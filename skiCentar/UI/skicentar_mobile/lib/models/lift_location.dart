import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_mobile/models/location.dart';

part 'lift_location.g.dart';

@JsonSerializable()
class LiftLocation implements Location {
  int? id;
  @override
  double? locationX;
  @override
  double? locationY;

  LiftLocation({this.id, this.locationX, this.locationY});

  factory LiftLocation.fromJson(Map<String, dynamic> json) =>
      _$LiftLocationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LiftLocationToJson(this);
}
