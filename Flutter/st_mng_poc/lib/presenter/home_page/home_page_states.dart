// ignore_for_file: public_member_api_docs, sort_constructors_first
// sealed class HomeScreenState {}

// final class HomeScreenLoadingState extends HomeScreenState {}

// final class HomeScreenSuccessfulState extends HomeScreenState {
//   final String userName;

//   HomeScreenSuccessfulState(this.userName);
// }

// final class HomeScreenErrorState extends HomeScreenState {
//   final String errorMessage;

//   HomeScreenErrorState(this.errorMessage);
// }

import 'package:st_mng_poc/dto/user_dto.dart';

/// ex2
enum UserStatus { autenticado, naoAutenticado, loading, error }

class HomeScreenState {
  final List<UserDto> user;
  final UserStatus status;
  final bool loading;

  HomeScreenState({
    required this.user,
    required this.loading,
    this.status = UserStatus.naoAutenticado,
  });

  factory HomeScreenState.initial() =>
      HomeScreenState(user: [], loading: false);

  factory HomeScreenState.loading() =>
      HomeScreenState(user: [], loading: true, status: UserStatus.loading);

  factory HomeScreenState.success(List<UserDto> users) => HomeScreenState(
        user: users,
        loading: false,
        status: UserStatus.autenticado,
      );

  factory HomeScreenState.error() =>
      HomeScreenState(user: [], loading: false, status: UserStatus.error);

  @override
  bool operator ==(covariant HomeScreenState other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.status == status &&
        other.loading == loading;
  }

  @override
  int get hashCode => user.hashCode ^ status.hashCode ^ loading.hashCode;

  @override
  String toString() =>
      'HomeScreenState(user: $user, status: $status, loading: $loading)';
}
