import '../../dto/user_dto.dart';

class FavoritePageStates {
  final List<UserDto> users;

  FavoritePageStates({
    this.users = const [],
  });

  factory FavoritePageStates.initial() => FavoritePageStates();

  factory FavoritePageStates.populated(List<UserDto> users) =>
      FavoritePageStates(
        users: users,
      );
}
