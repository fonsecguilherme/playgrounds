import 'package:drift/drift.dart';
import 'package:st_mng_poc/database.dart';

class UserDto {
  final int? id;
  final String name;
  final int? age;

  UserDto({this.id, required this.name, this.age = 0});

  UsersCompanion toCompanion() {
    return UsersCompanion.insert(
        id: id != null ? Value(id!) : const Value.absent(),
        name: name,
        age: age ?? 0);
  }

  factory UserDto.fromDatabase(User user) {
    return UserDto(id: user.id, name: user.name, age: user.age);
  }

  @override
  String toString() {
    return 'UserDTO(nome: $name, age: $age)';
  }
}
