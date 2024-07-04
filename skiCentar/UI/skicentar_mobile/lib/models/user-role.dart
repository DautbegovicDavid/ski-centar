
import 'package:json_annotation/json_annotation.dart';

part 'user-role.g.dart';
@JsonSerializable()
class UserRole{
  int? id;
  String? name;
  
  UserRole({this.id,this.name});

  factory UserRole.fromJson(Map<String,dynamic> json) => _$UserRoleFromJson(json);

  Map<String,dynamic> toJson() => _$UserRoleToJson(this);
}