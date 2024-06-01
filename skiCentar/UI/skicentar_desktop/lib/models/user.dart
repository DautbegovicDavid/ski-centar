
import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_desktop/models/user-role.dart';

part 'user.g.dart';
@JsonSerializable()
class User{
  int? id;
  String? email;
  UserRole? userRole;
  
  User({this.id,this.email,this.userRole});

  factory User.FromJson(Map<String,dynamic> json) => _$UserFromJson(json);

  Map<String,dynamic> toJson() => _$UserToJson(this);
}