//
//  HomeViewPage.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 05/04/25.
//

import SwiftUI

struct HomeViewPage: View{
    
    @State private var zipValue: String = ""
    //    @FocusState private var emailFieldIsFocused: Bool = false
    
    @StateObject var vm = HomePageVM()
    
    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView("Carregando...")
            } else if let message = vm.errorMessage {
                Text(message)
            } else if vm.address != nil {
                CustomCardView(logradouro: vm.safeAddress.logradouro, cep: vm.safeAddress.cep, cidade: String(vm.safeAddress.cep), estado: vm.safeAddress.estado)
            } else {
                VStack{
                    TextField(
                        "Digite o CEP a ser pesquisadi",
                        text: $zipValue
                        
                    )
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    
                    Button {
                        if let zipInt = Int(zipValue) {
                               vm.fetchAddress(zip: zipInt)
                           } else {
                               vm.errorMessage = "CEP inválido"
                           }
                    } label: {
                        Label("Procurar...", systemImage: "arrow.right.circle")
                    }
                }
            }
        }
    }
}
