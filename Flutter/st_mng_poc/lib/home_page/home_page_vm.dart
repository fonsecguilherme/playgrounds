// import 'package:flutter/material.dart';
// import 'package:video_player_imp/repository/user_repository.dart';
// import 'package:video_player_imp/state/home_states.dart';

// class HomePageVm {
//   var state = ValueNotifier<HomeScreenState>(HomeScreenLoadingState());
//   final userRepository = UserRepository();

//   Future<void> onInit() async {
//     _tryToFetchUserData();
//   }

//   Future<void> onRefreshUserData() async {
//     _tryToFetchUserData();
//   }

//   Future<void> _tryToFetchUserData() async {
//     try {
//       state.value = HomeScreenLoadingState();
//       final response = await userRepository.getUserData();
//       state.value = HomeScreenSuccessfulState(response.name);
//     } catch (e) {
//       state.value = HomeScreenErrorState('An error occurred');
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:st_mng_poc/dto/user_dto.dart';

import '../repository/user_repository.dart';
import 'home_page_states.dart';

/// Alternativa 2
///
class HomePageVm {
  var state = ValueNotifier<HomeScreenState>(HomeScreenState.initial());
  final userRepository = UserRepository();
  List<UserDto> users = [];

  Future<void> onInit() async {
    _tryToFetchUserData();
  }

  Future<void> onRefreshUserData() async {
    _tryToFetchUserData();
  }

  Future<void> errorUserData() async {
    state.value = HomeScreenState.loading();

    await Future.delayed(Duration(seconds: 2));

    state.value = HomeScreenState.error();
  }

  Future<void> resetAppState() async {
    state.value = HomeScreenState.loading();

    await Future.delayed(Duration(seconds: 2));

    state.value = HomeScreenState.initial();
  }

  Future<void> _tryToFetchUserData() async {
    try {
      state.value = HomeScreenState.loading();
      final response = await userRepository.getUserData();
      state.value = HomeScreenState.success([response]);
    } catch (e) {
      state.value = HomeScreenState.error();
    }
  }
}
