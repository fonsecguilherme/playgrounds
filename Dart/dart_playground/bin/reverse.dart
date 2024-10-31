void main() {
  final name = 'Guilherme';

  final newArray = name.split(''); //Transformando a string em um array

  print('Transformando uma String em array: $newArray\n'
      'Do tipo ${newArray.runtimeType}');

  final reversedName = newArray.reversed.join();

  print(reversedName);
}
