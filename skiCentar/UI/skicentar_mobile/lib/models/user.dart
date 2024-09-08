import 'package:json_annotation/json_annotation.dart';
import 'package:skicentar_mobile/models/user_role.dart';
import 'package:skicentar_mobile/models/user_detail.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  int? userRoleId;
  String? email;
  UserRole? userRole;
  UserDetail? userDetails;
  DateTime? registrationDate;
  bool? isVerified;
  bool? hasActiveTicket;

  User({this.id, this.email, this.userRole});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
