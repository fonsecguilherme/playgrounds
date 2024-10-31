// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:equatable/equatable.dart';
// import 'package:http/http.dart' as http;

// void main() async {
//   final repository = DogRepository();
//   try {
//     final breeds = await repository.getAllBreeds();
//     print('Breeds data: $breeds');
//   } catch (e) {
//     print('Error in main: $e'); // Captura e trata a exceção aqui
//   }
// }

// class DogRepository {
//   Future<BreedsModel> getAllBreeds() async {
//     // String url = 'https://dog.ceo/api/breeds/list/aall';
//     String url = 'http://10.0.2.2:3001/v1/videos/history?limit=10';

//     // final response = await http.get(Uri.parse(url));

//     // print(response.statusCode.toString());

//     // switch (response.statusCode) {
//     //   case HttpStatus.ok: // Código 200 para sucesso
//     //     print('Deu bom');
//     //     final responseData = json.decode(response.body);
//     //     return BreedsModel.fromJson(responseData);

//     //   case HttpStatus.notFound:
//     //     throw Exception('URL not found: ${response.request?.url}');

//     //   default:
//     //     throw Exception('Failed to load breeds: ${response.statusCode}');
//     // }

//     try {
//       final response = await http.get(Uri.parse(url));

//       print(response.statusCode.toString());

//       switch (response.statusCode) {
//         case HttpStatus.ok:
//           print('Deu bom');
//           final responseData = json.decode(response.body);
//           return BreedsModel.fromJson(responseData);

//         case HttpStatus.notFound:
//           throw Exception('URL not found: ${response.request?.url}');

//         default:
//           throw Exception('Failed to load breeds: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('DEU RUIM DEMAIS PAIZÃOOOOOOOOOOOOOOOOO: $e');
//     }
//   }

//   Future<DogModel> getDogDetails(String breed) async {
//     String url = 'https://dog.ceo/api/breed/$breed/images';

//     final response = await http.get(Uri.parse(url));

//     log(response.statusCode.toString());

//     if (response.statusCode == 200) {
//       return DogModel.fromRawJson(response.body);
//     } else {
//       throw Exception();
//     }
//   }
// }

// class BreedsModel extends Equatable {
//   final Map<String, List<String>> message;
//   final String status;

//   const BreedsModel({
//     required this.message,
//     required this.status,
//   });

//   factory BreedsModel.fromRawJson(String str) =>
//       BreedsModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory BreedsModel.fromJson(Map<String, dynamic> json) => BreedsModel(
//         message: Map.from(json["message"]).map((k, v) =>
//             MapEntry<String, List<String>>(
//                 k, List<String>.from(v.map((x) => x)))),
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "message": Map.from(message).map((k, v) =>
//             MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
//         "status": status,
//       };

//   @override
//   List<Object?> get props => [
//         message,
//         status,
//       ];
// }

// class DogModel {
//   final List<String> message;
//   final String status;

//   DogModel({
//     required this.message,
//     required this.status,
//   });

//   factory DogModel.fromRawJson(String str) =>
//       DogModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory DogModel.fromJson(Map<String, dynamic> json) => DogModel(
//         message: List<String>.from(json["message"].map((x) => x)),
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "message": List<dynamic>.from(message.map((x) => x)),
//         "status": status,
//       };
// }
