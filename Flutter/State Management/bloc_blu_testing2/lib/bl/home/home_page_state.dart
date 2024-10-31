// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../model/github_user_model.dart';

//! 1 opção

class HomePageState extends Equatable {
  const HomePageState({
    required this.isLoading,
    required this.users,
    required this.errorType,
  });

  final bool isLoading;
  final List<GithubUser> users;
  final HomePageErrorType errorType;

  factory HomePageState.initial() => const HomePageState(
        isLoading: false,
        users: [],
        errorType: HomePageErrorType.none,
      );

  factory HomePageState.loading() => const HomePageState(
        isLoading: true,
        users: [],
        errorType: HomePageErrorType.none,
      );

  factory HomePageState.sucess({required List<GithubUser> users}) =>
      HomePageState(
        isLoading: false,
        users: users,
        errorType: HomePageErrorType.none,
      );

  factory HomePageState.error({required HomePageErrorType error}) =>
      HomePageState(
        isLoading: false,
        users: const [],
        errorType: error,
      );

  @override
  List<Object> get props => [isLoading, users, errorType];
}

enum HomePageErrorType { none, fetchData }

//! opção 2

// enum HomePageStatus { initial, loading, success, failure }

// enum HomePageErrorType {
//   none(''),
//   fetchData('Erro ao obter info');

//   const HomePageErrorType(String this.message);
//   final String? message;

//   String getMessage() => message ?? '';
// }

// extension HomePageStatusX on HomePageStatus {
//   bool get isInitial => this == HomePageStatus.initial;
//   bool get isLoading => this == HomePageStatus.loading;
//   bool get isSuccess => this == HomePageStatus.success;
//   bool get isFailure => this == HomePageStatus.failure;
// }

// class HomePageState extends Equatable {
//   final HomePageStatus status;
//   final AddressModel? address;
//   final List<GithubUser> users;
//   final HomePageErrorType error;

//   const HomePageState({
//     required this.status,
//     this.address,
//     this.users = const [],
//     this.error = HomePageErrorType.none,
//   });

//   HomePageState copyWith({
//     HomePageStatus? status,
//     AddressModel? address,
//     List<GithubUser>? users,
//     HomePageErrorType? error,
//   }) {
//     return HomePageState(
//       status: status ?? this.status,
//       address: address ?? this.address,
//       users: users ?? this.users,
//       error: error ?? this.error,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         status,
//         address,
//         users,
//         error,
//       ];
// }
