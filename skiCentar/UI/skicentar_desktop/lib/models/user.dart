
import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_desktop/models/user-role.dart';
import 'package:skicentar_desktop/models/user_detail.dart';

part 'user.g.dart';
@JsonSerializable()
class User{
  int? id;
  int? userRoleId;
  String? email;
  UserRole? userRole;
  DateTime? registrationDate;
  bool? isVerified;
  UserDetail? userDetails;
  
  User({this.id,this.email,this.userRole});

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);

  Map<String,dynamic> toJson() => _$UserToJson(this);
}