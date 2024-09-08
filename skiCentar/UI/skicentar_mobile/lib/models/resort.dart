import 'package:json_annotation/json_annotation.dart';

part 'resort.g.dart';

@JsonSerializable()
class Resort {
  int? id;
  String? name;
  String? location;
  int? elevation;
  String? skiWorkHours;

  Resort({this.id, this.name});

  @override
  bool operator ==(o) => o is Resort && o.name == name && o.id == id;

  factory Resort.fromJson(Map<String, dynamic> json) => _$ResortFromJson(json);

  Map<String, dynamic> toJson() => _$ResortToJson(this);
}
