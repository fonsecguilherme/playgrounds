class HerancaFuncionario {
  String? nome;
  double salario = 0.0;
  List<String> tarefas = [];
  void trabalhar() {
    print('$runtimeType trabalhando..');
  }
}

class HerancaProgramador extends HerancaFuncionario {
  List<String>? linguagens;

  @override
  void trabalhar() {
    print('Prigramador trabalho...');
  }
}

class HerancaGerente extends HerancaFuncionario {
  double? bonus;

  @override
  void trabalhar() {
    print('Gerente trabalhando...');
  }
}

class Startup {
  Startup(this.funcionarios);
  List<HerancaFuncionario> funcionarios;
  
  void novoProjeto() {
    for (var f in funcionarios) {
      f.trabalhar();
    }
  }
}
