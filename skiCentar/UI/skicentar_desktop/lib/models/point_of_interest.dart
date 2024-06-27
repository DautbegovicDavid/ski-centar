import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_desktop/models/poi_category.dart';
import 'package:skicentar_desktop/models/resort.dart';

part 'point_of_interest.g.dart';

@JsonSerializable()
class PointOfInterest {
  int? id;
  String? name;
  int? resortId;
  Resort? resort;
  int? categoryId;
  PoiCategory? category;
  double? locationX;
  double? locationY;
  String? description;

  PointOfInterest({this.id, this.name,this.resortId,this.categoryId,this.locationX,this.locationY});

  factory PointOfInterest.fromJson(Map<String,dynamic> json) => _$PointOfInterestFromJson(json);

  Map<String,dynamic> toJson() => _$PointOfInterestToJson(this);
}
