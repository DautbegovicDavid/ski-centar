import 'package:json_annotation/json_annotation.dart';

part 'user_poi.g.dart';

@JsonSerializable()

class UserPoi{
  String? interactionType;
  DateTime? interactionTimestamp;
  int? userId;
  int? poiId;
  
  UserPoi({this.userId,this.poiId,this.interactionTimestamp,this.interactionType});

  factory UserPoi.fromJson(Map<String,dynamic> json) => _$UserPoiFromJson(json);

  Map<String,dynamic> toJson() => _$UserPoiToJson(this);
}