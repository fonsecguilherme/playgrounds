import 'package:equatable/equatable.dart';

import '../../../model/github_user_model.dart';

class HomePageBluState extends Equatable {
  const HomePageBluState({
    required this.isLoading,
    required this.users,
    required this.errorType,
  });

  final bool isLoading;
  final List<GithubUser> users;
  final HomePageBluErrorType errorType;

  factory HomePageBluState.initial() => const HomePageBluState(
        isLoading: false,
        users: [],
        errorType: HomePageBluErrorType.none,
      );

  factory HomePageBluState.loading() => const HomePageBluState(
        isLoading: true,
        users: [],
        errorType: HomePageBluErrorType.none,
      );

  factory HomePageBluState.sucess({required List<GithubUser> users}) =>
      HomePageBluState(
        isLoading: false,
        users: users,
        errorType: HomePageBluErrorType.none,
      );

  factory HomePageBluState.error({required HomePageBluErrorType error}) =>
      HomePageBluState(
        isLoading: false,
        users: const [],
        errorType: error,
      );

  @override
  List<Object> get props => [isLoading, users, errorType];
}

enum HomePageBluErrorType { none, fetchData }
