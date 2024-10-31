void main() {
  var pessoa = Pessoa(idade: 27, nome: 'Guilherme', documento: '123456');
  print(pessoa);
  print(pessoa.hashCode);

  print('--------');

  pessoa = pessoa.copyWith(nome: 'Nicole');
  print(pessoa);
  print(pessoa.hashCode);
}

class Pessoa {
  final int idade;
  final String nome;
  final String documento;

  Pessoa({
    required this.idade,
    required this.nome,
    required this.documento,
  });

  copyWith({
    String? nome,
    int? idade,
    String? documento,
  }) {
    return Pessoa(
      nome: nome ?? this.nome,
      idade: idade ?? this.idade,
      documento: documento ?? this.documento,
    );
  }

  @override
  String toString() {
    return 'Olá, meu nome é $nome, tenho $idade e o meu documento é de identidade é $documento';
  }
}
