import 'dart:convert';

import 'package:equatable/equatable.dart';

void main() {
  final List<FavoriteModel> favoriteModelList = [
    FavoriteModel(
      // description: 'minha descrição',
      addressModel: AddressModel(
        cep: '12345',
        logradouro: 'logradouro',
        complemento: 'complemento',
        bairro: 'bairro',
        localidade: 'localidade',
        uf: 'uf',
        ddd: 'ddd',
      ),
    )
  ];

  final endereco = AddressModel(
    cep: '12345',
    logradouro: 'logradouro',
    complemento: 'complemento',
    bairro: 'bairro',
    localidade: 'localidade',
    uf: 'uf',
    ddd: 'ddd',
  );

  final myjson = {
    "addressModel": {
      "cep": '12345',
      "logradouro": "logradouro",
      "complemento": "complemento",
      "bairro": "bairro",
      "localidade": "localidade",
      "uf": "uf",
      "ddd": "ddd"
    },
    "tags": [],
    "description": "Sem descrição"
  };

  final firstItem = favoriteModelList.elementAt(0);

  print(firstItem.toJson());

  //! Transformando

  final myFavoriteModel = FavoriteModel.fromJson(myjson);

  print(myFavoriteModel.addressModel.cep);

  if (favoriteModelList.any(
    (element) => element.addressModel == endereco,
  )) {
    print('Deu bom demais familia');
  } else {
    print('Deu ruim tente novamente');
  }
}

class FavoriteModel {
  final AddressModel addressModel;
  final List<String> tags;
  final String description;

  FavoriteModel({
    required this.addressModel,
    List<String>? tags,
    String? description,
  })  : tags = tags ?? [],
        description = description ?? 'Sem descrição';

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      addressModel: AddressModel.fromJson(json['addressModel']),
      tags: (json['tags'] as List<dynamic>?)
              ?.map((tag) => tag as String)
              .toList() ??
          [],
      description: json['description'] ?? 'Sem descrição',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressModel': addressModel.toJson(),
      'tags': tags,
      'description': description.isNotEmpty ? description : 'Sem descrição',
    };
  }

  FavoriteModel copyWith({
    AddressModel? addressModel,
    List<String>? tags,
    String? description,
  }) {
    return FavoriteModel(
      addressModel: addressModel ?? this.addressModel,
      tags: tags ?? this.tags,
      description: description ?? this.description,
    );
  }
}

class AddressModel extends Equatable {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String ddd;

  const AddressModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ddd,
  });

  factory AddressModel.fromRawJson(String str) =>
      AddressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        cep: json["cep"],
        logradouro: json["logradouro"],
        complemento: json["complemento"],
        bairro: json["bairro"],
        localidade: json["localidade"],
        uf: json["uf"],
        ddd: json["ddd"],
      );

  Map<String, dynamic> toJson() => {
        "cep": cep,
        "logradouro": logradouro,
        "complemento": complemento,
        "bairro": bairro,
        "localidade": localidade,
        "uf": uf,
        "ddd": ddd,
      };

  @override
  List<Object?> get props => [
        cep,
        logradouro,
        complemento,
        bairro,
        localidade,
        uf,
        ddd,
      ];
}
