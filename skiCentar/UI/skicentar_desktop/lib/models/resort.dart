
import 'package:json_annotation/json_annotation.dart';

part 'resort.g.dart';
@JsonSerializable()
class Resort{
  int? id;
  String? name;
  String? location;
  int? elevation;
  String? skiWorkHours;
  
  Resort({this.id,this.name});

  factory Resort.FromJson(Map<String,dynamic> json) => _$ResortFromJson(json);

  Map<String,dynamic> toJson() => _$ResortToJson(this);
}