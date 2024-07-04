
import 'package:json_annotation/json_annotation.dart';

part 'poi_category.g.dart';
@JsonSerializable()
class PoiCategory{
  int? id;
  String? name;
  
  PoiCategory({this.id,this.name});

  factory PoiCategory.fromJson(Map<String,dynamic> json) => _$PoiCategoryFromJson(json);

  Map<String,dynamic> toJson() => _$PoiCategoryToJson(this);
}