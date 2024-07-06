
import 'package:json_annotation/json_annotation.dart';

part 'user_detail.g.dart';
@JsonSerializable()
class UserDetail{
  int? id;
  String? name;
  String? lastName;
  DateTime? dateOfBirth;
  
  UserDetail(this.id);

  factory UserDetail.fromJson(Map<String,dynamic> json) => _$UserDetailFromJson(json);

  Map<String,dynamic> toJson() => _$UserDetailToJson(this);
}