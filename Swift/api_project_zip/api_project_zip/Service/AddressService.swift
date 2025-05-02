//
//  Untitled.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 22/04/25.
//

import Foundation


class AddressService {
    
    // completion é tipo um async await de flutter
    func fetchAddresses(zipValue: String, completion: @escaping (Result<AddressModel, Error>) -> Void) {
        guard let url = URL(string: "https://viacep.com.br/ws/\(zipValue)/json/") else {
            return
        }

        // A constante "task" tem um "guard let data" que anuncia que se "data" possuir valor, o mesmo é atribuído,
        // mas também é necessário que erro seja nulo. Ou seja, só é utilizado o dado se não houver erro.
        // O "return" finaliza a função se "error" receber algum valor
        
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response, let data = data else {
                completion(.failure(ApiError.genericError))
                return
            }
            
            do {
                let parsedAddress = try JSONDecoder().decode(AddressModel.self, from: data)
                
                //se o error vier preenchido quer dizer que não foi possível encontrar o CEP
                if let error = parsedAddress.error{
                    completion(.failure(ApiError.addressNotFound))
                }else {
                    completion(.success(parsedAddress))
                }
                
            } catch {
                completion(.failure(ApiError.genericError))
            }
        }
        task.resume()
    }
}

enum ApiError: Error {
    case addressNotFound
    case genericError
    
    var message: String {
        switch self {
        case .addressNotFound:
            return "Endereço não encontrado"
        case .genericError:
            return "Erro Generico"
        }
    }
}
