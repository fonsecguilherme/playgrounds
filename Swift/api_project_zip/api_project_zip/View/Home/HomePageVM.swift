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
    @Published var error: Error?

    func fetchAddress(zip: Int) {

        //Verificando se a url é válida...
        guard let url = URL(string: "https://viacep.com.br/ws/\(zip)/json/") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
//            A constante "task" tem um "guard let data" que anuncia que se "data" possuir valor, o mesmo é atribuído,
//            mas também é necessário que erro seja nulo. Ou seja, só é utilizado o dado se não houver erro.
//            O "return" finaliza a função se "error" receber algum valor

            guard let data = data, error == nil else { return }
            
            do {
                let parsed = try JSONDecoder().decode(ViaCepModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.address = parsed
                    }
            } catch {
                print(error)
            }
        }
        task.resume()
    }

}
