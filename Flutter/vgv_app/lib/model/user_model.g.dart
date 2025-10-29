// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  login: json['login'] as String,
  avatarUrl: json['avatar_url'] as String,
  htmlUrl: json['html_url'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'login': instance.login,
  'avatar_url': instance.avatarUrl,
  'html_url': instance.htmlUrl,
  'type': instance.type,
};
