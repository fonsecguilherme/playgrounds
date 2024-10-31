void main() {
  /*
  LinkedHashSet
  Um LinkedHashSet tem um funcionamento semelhante ao de uma lista,
  pois ele mantém a ordem de inserção dos elementos
  */

  // final megasena = <int>{};
  // megasena.add(13);
  // megasena.add(08);
  // megasena.add(73);
  //
  // print(megasena);
  //
  // print(megasena.elementAt(0));

  /*
  HashSet não mantém a ordem de inserção e sim ordena os elementos
  através da implementação do hashCode desses elementos.
  */
  // final megasena = HashSet<int?>();
  // megasena.addAll([44, 35, 4, 11, null, 29, 4, null, 35, 57]);
  // print(megasena); // > {35, 4, 57, 11, null, 44, 29}

  final clientes = <int, String>{};
  clientes[1] = 'Rafael';
  clientes[1] = 'Juliana';
  clientes.putIfAbsent(1, () => 'João');
  // clientes.putIfAbsent(2, () => 'Maria');
  print(clientes); // {1: Juliana, 2: João}
}
