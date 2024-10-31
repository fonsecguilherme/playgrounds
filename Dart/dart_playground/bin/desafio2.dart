import 'dart:io';
import 'dart:math';

void main() {
  print('digite um número para fazer a verificação:');
  final number = stdin.readLineSync();

  isArmstrong(int.parse(number!))
      ? print('É um número de armstrong')
      : print('Não é um número de armstrong');
}

bool isArmstrong(int num) {
  int sum = 0;
  final stringNum = num.toString().split('');
  int expoent = stringNum.length;

  for (var element in stringNum) {
    sum += pow(int.parse(element), expoent).toInt();
  }

  print('soma total $sum');

  return num == sum;
}
