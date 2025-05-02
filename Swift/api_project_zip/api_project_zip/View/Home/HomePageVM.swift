//
//  HomePageVM.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 05/04/25.
//

import Foundation

//ObservableObject, que permite criar objetos que podem ser observados por views para que estas views possam ser atualizadas
//automaticamente sempre que os dados dentro do objeto mudarem

enum HomePageState {
    case empty
    case loading
    case error(String )
    case success(AddressModel)
    
}

class HomePageVM: ObservableObject {
    //@Published indica que qualquer view que esteja observando a propriedade "address" será notificada quando ela mudar.

    @Published var state: HomePageState = .empty
    //Poderia ser feito sobre injeção de dependencia
    private let service = AddressService()

    func fetchAddress(zip: String) {
       self.state = .loading
        
        service.fetchAddresses(zipValue: zip) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let address):
                    self?.state = .success(address)
                case .failure(let err):
                    if let error = err as? ApiError{
                        self?.state = .error(error.message)
                    } else {
                        self?.state = .error("Erro desconhecido")
                    }
                }
            }
        }
    }
}
