import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_mobile/models/trail.dart';
import 'package:skicentar_mobile/models/user.dart';

part 'ski_accident.g.dart';

@JsonSerializable()
class SkiAccident {
  int? id;
  String? description;
  bool? isActive;
  bool? isReporterInjured;
  int? userId;
  int? trailId;
  int? peopleInvolved;
  double? locationX;
  double? locationY;
  DateTime? timestamp;

  Trail? trail;
  User? user;

  SkiAccident({this.id, this.locationX, this.locationY});

  factory SkiAccident.fromJson(Map<String, dynamic> json) =>
      _$SkiAccidentFromJson(json);

  Map<String, dynamic> toJson() => _$SkiAccidentToJson(this);
}
