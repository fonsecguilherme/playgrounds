abstract class IDatabase {
  Future<T> insert<T>(T data);

  Future<List<T>> select<T>();
}
