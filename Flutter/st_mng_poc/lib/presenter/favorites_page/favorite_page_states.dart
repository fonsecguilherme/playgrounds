import '../../database.dart';

class FavoritePageStates {
  final List<User> users;

  FavoritePageStates({
    this.users = const [],
  });

  factory FavoritePageStates.initial() => FavoritePageStates();

  factory FavoritePageStates.populated(List<User> users) => FavoritePageStates(
        users: users,
      );
}
