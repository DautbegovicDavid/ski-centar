// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      userRole: json['userRole'] == null
          ? null
          : UserRole.fromJson(json['userRole'] as Map<String, dynamic>),
    )
      ..userRoleId = (json['userRoleId'] as num?)?.toInt()
      ..userDetails = json['userDetails'] == null
          ? null
          : UserDetail.fromJson(json['userDetails'] as Map<String, dynamic>)
      ..registrationDate = json['registrationDate'] == null
          ? null
          : DateTime.parse(json['registrationDate'] as String)
      ..isVerified = json['isVerified'] as bool?
      ..hasActiveTicket = json['hasActiveTicket'] as bool?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'userRoleId': instance.userRoleId,
      'email': instance.email,
      'userRole': instance.userRole,
      'userDetails': instance.userDetails,
      'registrationDate': instance.registrationDate?.toIso8601String(),
      'isVerified': instance.isVerified,
      'hasActiveTicket': instance.hasActiveTicket,
    };
