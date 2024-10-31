void main() {
  print('Objeto Pessoa');
  final namesObj = [
    Pessoa(name: "Guilherme"),
    Pessoa(name: 'Nicole'),
    Pessoa(name: 'Selma'),
    Pessoa(name: 'Genivaldo'),
    Pessoa(name: 'Bichano'),
    Pessoa(name: 'Jura'),
    Pessoa(name: 'Cida'),
  ];

  final elements = namesObj.where((element) => element.name.contains('G'));
  for (var element in elements) {
    print(element.name);
  }
  print('--------------------------------------------------------------------');
  print('String');
  final namesStr = [
    "Guilherme",
    'Nicole',
    'Selma',
    'Genivaldo',
    'Bichano',
    'Jura',
    'Cida',
  ];

  final primeiro = namesStr.firstWhere(
    (element) => element.startsWith('z'),
    orElse: () => 'Não tem resultado',
  );

  print(primeiro);

  final elementsStr = namesStr.where(
    (element) => element.contains('a'),
  );

  print(elementsStr);

  final todos = namesStr.every(
    (element) => element.length >= 4,
  );

  print('Todos itens maiores que 7: $todos');
}

class Pessoa {
  final String name;

  Pessoa({required this.name});
}
