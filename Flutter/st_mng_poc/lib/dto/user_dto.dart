import 'package:st_mng_poc/database.dart';

class UserDto {
  final String name;
  final int? age;

  UserDto({required this.name, this.age = 0});

  UsersCompanion toCompanion() {
    return UsersCompanion.insert(name: name, age: age ?? 0);
  }

  factory UserDto.fromDatabase(User user) {
    return UserDto(name: user.name, age: user.age);
  }

  @override
  String toString() {
    return 'UserDTO(nome: $name, age: $age)';
  }
}
