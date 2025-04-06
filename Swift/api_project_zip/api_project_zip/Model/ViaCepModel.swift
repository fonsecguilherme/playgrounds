//
//  ViaCepModel.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 05/04/25.
//

//Decodable — Mapeia parte da API / Pega da URL e traz pro array. Permite a conversão do arquivo JSON em algum tipo de dado do Swift.
//Encodable — Pega um dado do array e envia pra API, ou seja, converte um tipo de dado do Swift em alguma representação como o JSON.
//Codable — É a soma dos dois anteriores. Aceita somente buscar todos os dados da API.


struct ViaCepModel: Codable {
    let cep, logradouro, complemento, unidade: String
    let bairro, localidade, uf, estado: String
    let regiao, ddd: String
    
    
    var complementoOrDefault: String {
          complemento.isEmpty ? "Sem complemento" : complemento
      }
}
