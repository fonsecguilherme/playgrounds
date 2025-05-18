import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:st_mng_poc/dto/user_dto.dart';
import 'package:st_mng_poc/presenter/favorites_page/favorite_page_states.dart';

import '../../domain/i_database.dart';

class FavoriteVM {
  final IDatabase database;
  final ValueNotifier<FavoritePageStates> state;

  FavoriteVM({required this.database})
      : state = ValueNotifier<FavoritePageStates>(FavoritePageStates.initial());

  List<UserDto> users = [];

  Future<void> fetchData() async {
    users = await database.select<UserDto>();

    log('Items in database $users');

    if (users.isEmpty) {
      state.value = FavoritePageStates.initial();
    } else {
      state.value = FavoritePageStates.populated(users);
    }
  }

  Future<void> deleteUser(UserDto user) async {
    await database.delete(user.toCompanion());
  }
}
