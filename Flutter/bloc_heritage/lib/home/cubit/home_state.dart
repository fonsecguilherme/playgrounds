import 'package:equatable/equatable.dart';

enum AppBarType { padrao, custom, sucesso }

sealed class HomeState extends Equatable {
  final String? appbarTitle;
  final AppBarType type;

  const HomeState({
    required this.appbarTitle,
    this.type = AppBarType.padrao,
  });
}

final class InitialHomeState extends HomeState {
  const InitialHomeState({
    required super.appbarTitle,
    super.type,
  });

  @override
  List<Object?> get props => [];
}

final class LoadingHomeState extends HomeState {
  const LoadingHomeState({
    required super.appbarTitle,
    super.type = AppBarType.custom,
  });

  @override
  List<Object?> get props => [];
}

final class SuccessHomeState extends HomeState {
  const SuccessHomeState({
    required super.appbarTitle,
    super.type = AppBarType.sucesso,
  });

  @override
  List<Object?> get props => [];
}

final class ErrorHomeState extends HomeState {
  const ErrorHomeState({
    required super.appbarTitle,
    super.type,
  });

  @override
  List<Object?> get props => [];
}
