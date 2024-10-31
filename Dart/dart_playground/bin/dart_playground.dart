import 'package:dio/dio.dart';

void main(List<String> arguments) {
  final repo = Repo();

  print('Olá mundo');

  print('--- RESPOSTA DO DIO ABAIXO ---');

  print(repo.getData());

try {
  
} catch (e) {
  print(e);
}
}

class Repo {
  final dio = Dio();
  Future<void> getData() async {
    String url = 'https://fakestoreapi.com/products';

    final response = await dio.get(url);

    print(response);
  }
}


