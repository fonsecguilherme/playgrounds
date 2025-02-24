import 'package:poo_testing/models/heranca_programador.dart';

void main(List<String> arguments) {
// heranca

 HerancaFuncionario funcionario = HerancaFuncionario();
HerancaFuncionario programador = HerancaProgramador();
HerancaFuncionario gerente = HerancaGerente();
final startup = Startup([funcionario, programador, gerente]);
startup.novoProjeto();

//-----------------------------------------------------------------------------------------------
  /*
    //! ao usar construtor sem o const, mesmo com mesmo valores, eles apontarão para valores diferentes
  final programador1 = Programador(nome: 'Guilherme');
  final programador2 = Programador(nome: 'Guilherme');

  //! se eu quiser compara los, preciso sobrescrever os operador de == e hash
  print(
      'Construtor normal, são iguais? == sobrecrito ${programador1 == programador2}');

  //! ao usar construtor const o programador 1 e 2 apontam para o mesmo endereço de memória
  final programadorconst1 = const ProgramadorConst(nome: 'Guilherme');
  final programadorconst2 = const ProgramadorConst(nome: 'Guilherme');

  print(
      'Cconstrutor const, são iguais? == não sobrescrito ${programadorconst1 == programadorconst2}');

 */
}
