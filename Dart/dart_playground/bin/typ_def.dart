/// Object é uma classe pai de todos os outros tipos do dart
/// Function é o tipo uma Função tipo onTap lá no flutter

typedef Operacao = Object Function(double a, double b);

double somar(double a, double b) {
  return a + b;
}

String subtrair(double a, double b) {
  return (a - b).toString();
}

Object calcular(double a, double b, Operacao operacao) {
  return operacao(a, b);
}

void main() {
  print(calcular(22, 20, somar)); // > 42
  print(calcular(22, 20, subtrair)); // > 2
}
