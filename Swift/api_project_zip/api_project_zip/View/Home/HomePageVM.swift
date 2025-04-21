//
//  HomePageVM.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 05/04/25.
//

import Foundation

//ObservableObject, que permite criar objetos que podem ser observados por views para que estas views possam ser atualizadas
//automaticamente sempre que os dados dentro do objeto mudarem

class HomePageVM: ObservableObject {

    //@Published indica que qualquer view que esteja observando a propriedade "address" será notificada quando ela mudar.

    @Published var address: ViaCepModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var resetSearch: Bool = false
    
    var safeAddress: ViaCepModel {
          address ?? .empty
      }

    func fetchAddress(zip: String) {
        isLoading = true

        //Verificando se a url é válida...
        guard let url = URL(string: "https://viacep.com.br/ws/\(zip)/json/") else {
            return
        }

        // A constante "task" tem um "guard let data" que anuncia que se "data" possuir valor, o mesmo é atribuído,
        // mas também é necessário que erro seja nulo. Ou seja, só é utilizado o dado se não houver erro.
        // O "return" finaliza a função se "error" receber algum valor
        
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Erro: \(error.localizedDescription)"
                    self.isLoading = false
                }
                print("Erro: \(error.localizedDescription)")
                return
            }

            guard let response = response else {
                DispatchQueue.main.async {
                    self.errorMessage = "Resposta nula do servidor."
                    self.isLoading = false
                }
                print("Resposta nula do servidor.")
                return
            }

            guard let statusCode = response.getStatusCode() else {
                DispatchQueue.main.async {
                    self.errorMessage = "Não foi possível obter o status code."
                    self.isLoading = false
                }
                print("Não foi possível obter o status code.")
                return
            }

            print("Status code: \(statusCode)")

            switch statusCode {
            case 200:
                guard let data = data else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Dados vazios."
                        self.isLoading = false
                    }
                    print("Dados vazios.")
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       json["erro"] != nil {
                        DispatchQueue.main.async {
                            self.errorMessage = "CEP inválido."
                            self.isLoading = false
                        }
                        print("CEP inválido.")
                        return
                    }

                    let parsed = try JSONDecoder().decode(ViaCepModel.self, from: data)

                    DispatchQueue.main.async {
                        self.address = parsed
                        self.isLoading = false
                    }

                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Erro ao decodificar os dados."
                        self.isLoading = false
                    }
                    print("Erro de decodificação: \(error)")
                }

            case 400:
                DispatchQueue.main.async {
                    self.errorMessage = "CEP vazio ou inválido. (400)"
                    self.isLoading = false
                }
                print("CEP vazio ou inválido. (400)")

            default:
                DispatchQueue.main.async {
                    self.errorMessage = "Erro na API. Status code: \(statusCode)"
                    self.isLoading = false
                }
                print("Erro na API. Status code: \(statusCode)")
            }
        }

        task.resume()
    }
}
