//
//  ViaCepModelExtension.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 05/04/25.
//

extension ViaCepModel {
    static var empty: ViaCepModel {
        ViaCepModel(
            cep: "",
            logradouro: "",
            complemento: "Sem complemento",
            unidade: "",
            bairro: "",
            localidade: "",
            uf: "",
            estado: "",
            regiao: "",
            ddd: ""
        )
    }
}
