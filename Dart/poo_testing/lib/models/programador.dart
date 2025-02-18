class Programador {
  final String nome;
  final double salario;
  final List<String> tarefas;
  final List<String> linguagens;

  Programador({
    required this.nome,
    this.salario = 0.0,
    this.tarefas = const [],
    this.linguagens = const [],
  });

  //! Se minhas propriedades nãofossem final, poderia inicializar assi, mais parecido com java
  // Programador(
  //   String nome,
  //   double salario,
  //   List<String> tarefas,
  //   List<String> linguagens,
  // ) {
  //   this.nome = nome;
  //   this.salario = salario;
  //   this.tarefas = tarefas;
  //   this.linguagens = linguagens;
  // }

  void trabalhar() {}

  @override
  String toString() {
    return 'Programador(nome: $nome, salario: $salario, tarefas: $tarefas, linguagens: $linguagens)';
  }

  @override
  bool operator ==(covariant Programador other) {
    if (identical(this, other)) return true;

    return other.nome == nome;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        salario.hashCode ^
        tarefas.hashCode ^
        linguagens.hashCode;
  }
}

//Construtor const

class ProgramadorConst {
  final String nome;
  final double salario;
  final List<String> tarefas;
  final List<String> linguagens;

  const ProgramadorConst({
    required this.nome,
    this.salario = 0.0,
    this.tarefas = const [],
    this.linguagens = const [],
  });

  void trabalhar() {}

  @override
  String toString() {
    return 'Programador(nome: $nome, salario: $salario, tarefas: $tarefas, linguagens: $linguagens)';
  }
}
