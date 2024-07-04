
import 'package:json_annotation/json_annotation.dart';

part 'trail_difficulty.g.dart';
@JsonSerializable()
class TrailDifficulty{
  int? id;
  String? name;
  String? color;
  
  TrailDifficulty({this.id,this.name,this.color});

  factory TrailDifficulty.fromJson(Map<String,dynamic> json) => _$TrailDifficultyFromJson(json);

  Map<String,dynamic> toJson() => _$TrailDifficultyToJson(this);
}