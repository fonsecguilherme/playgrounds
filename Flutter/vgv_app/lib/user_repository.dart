import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vgv_app/model/user_model.dart';

class UserRepository {
  final url = 'https://api.github.com/users';

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        return body.map<UserModel>((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
