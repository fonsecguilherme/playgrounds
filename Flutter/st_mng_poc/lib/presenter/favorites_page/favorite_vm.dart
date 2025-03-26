import 'package:flutter/material.dart';
import 'package:st_mng_poc/database.dart';
import 'package:st_mng_poc/presenter/favorites_page/favorite_page_states.dart';

class FavoriteVM {
  final AppDatabase database;
  final ValueNotifier<FavoritePageStates> state;

  FavoriteVM({required this.database})
      : state = ValueNotifier<FavoritePageStates>(FavoritePageStates.initial());

  List<User> users = [];

  Future<void> fetchData() async {
    users = await database.select(database.users).get();

    if (users.isEmpty) {
      state.value = FavoritePageStates.initial();
    } else {
      state.value = FavoritePageStates.populated(users);
    }
  }
}
