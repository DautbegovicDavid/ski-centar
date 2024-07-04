import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_mobile/models/resort.dart';
import 'package:skicentar_mobile/models/trail_difficulty.dart';
import 'package:skicentar_mobile/models/trail_location.dart';

part 'trail.g.dart';

@JsonSerializable()

class Trail{
  int? id;
  String? name;
  bool? isFunctional;
  int? difficultyId;
  int? resortId;
  Resort? resort;
  double? length;
  TrailDifficulty? difficulty;
  List<TrailLocation>? trailLocations;
  
  Trail({this.id,this.name});

  factory Trail.fromJson(Map<String,dynamic> json) => _$TrailFromJson(json);

  Map<String,dynamic> toJson() => _$TrailToJson(this);
}