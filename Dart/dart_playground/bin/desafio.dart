import 'dart:math';

bool isArmstrong(int number) {
  String numberString = number.toString();
  int numDigits = numberString.length;

  print(numDigits);

  int sum = 0;
  for (int i = 0; i < numDigits; i++) {
    int digit = int.parse(numberString[i]);
    print('Calculando o $digit^$numDigits');
    sum += pow(digit, numDigits).toInt();
    print(sum);
  }

  return sum == number;
}

void main() {
  int number = 153;

  final name = "Guilherme";

  for (int i = 0; i < name.length; i++) {
    print(name[i]);
  }
}
