import 'package:json_annotation/json_annotation.dart';

part "response_login.g.dart";

@JsonSerializable()
class ResponseLogin {
  @JsonKey(name: 'a')
  final String token;

  @JsonKey(name: 'b')
  final Usuario user;

  @JsonKey(name: 'c')
  final int? idFuncionario;

  // @JsonKey(name: 'd')
  // final List<CardTo> cards;

  // @JsonKey(name: 'e')
  // final List<Periodo>? periodos;

  ResponseLogin({
    required this.token,
    required this.idFuncionario,
    required this.user,
    // required this.cards,
    // required this.periodos,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) =>
      _$ResponseLoginFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseLoginToJson(this);
}

// @JsonSerializable()
// class Periodo {
//   @JsonKey(name: 'a')
//   final String token;

//   Periodo({required this.token});
// }

// @JsonSerializable()
// class CardTo {
//   @JsonKey(name: 'a')
//   final String token;

//   CardTo({required this.token});
// }

@JsonSerializable()
class Usuario {
  @JsonKey(name: 'a')
  final String token;

  Usuario({required this.token});

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);
  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}
