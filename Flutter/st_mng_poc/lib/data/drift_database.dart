import 'package:st_mng_poc/domain/i_database.dart';

import '../database.dart';
import '../dto/user_dto.dart';

class DriftDatabase implements IDatabase {
  final AppDatabase _database;

  DriftDatabase({
    required AppDatabase database,
  }) : _database = database;

  @override
  Future<T> insert<T>(T data) async {
    if (data is UsersCompanion) {
      await _database.into(_database.users).insert(data);
    }

    throw UnimplementedError('O tipo passado para o banco não é suportado');
  }

  @override
  Future<List<T>> select<T>() async {
    if (T == UserDto) {
      final users = await _database.select(_database.users).get();
      return users.map((user) => UserDto.fromDatabase(user) as T).toList();
    }
    throw Exception('O tipo passado para o banco não é suportado');
  }
}
