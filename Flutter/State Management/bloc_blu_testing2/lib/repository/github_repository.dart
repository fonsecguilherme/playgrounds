import 'dart:convert';
import 'dart:developer';

import 'package:bloc_blu_testing2/model/github_user_model.dart';
import 'package:http/http.dart' as http;

class GithubRepostory {
  Future<List<GithubUser>> getUsers() async {
    const String url = 'https://api.github.com/users';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);

      log('$users');

      return users.map((user) => GithubUser.fromMap(user)).toList();
    } else {
      throw Exception('Falha ao obter usuários.');
    }
  }
}
