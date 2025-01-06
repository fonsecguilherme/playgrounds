// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseLogin _$ResponseLoginFromJson(Map<String, dynamic> json) =>
    ResponseLogin(
      token: json['a'] as String,
      idFuncionario: (json['c'] as num?)?.toInt(),
      user: Usuario.fromJson(json['b'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseLoginToJson(ResponseLogin instance) =>
    <String, dynamic>{
      'a': instance.token,
      'b': instance.user,
      'c': instance.idFuncionario,
    };

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => Usuario(
      token: json['a'] as String,
    );

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      'a': instance.token,
    };
