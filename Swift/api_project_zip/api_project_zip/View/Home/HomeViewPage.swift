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
        VStack{
            Text("Home Page view!")
            TextField(
                "Digite o CEP a ser pesquisado",
                text: $zipValue
            )
            .keyboardType(.numberPad)
            .textFieldStyle(.roundedBorder)
            .padding()
            CustomButton(zipValue: zipValue,buttonTextLabel: "Procurar..." , vm: vm)
            Group {
                if vm.isLoading {
                    ProgressView("Carregando...")
                } else if let message = vm.errorMessage {
                    Text(message)
                } else if vm.address != nil {
                    
                    ResultView(vm: vm)
                    
//                    CustomCardView(logradouro: vm.safeAddress.logradouro, cep: vm.safeAddress.cep, cidade: String(vm.safeAddress.cep), estado: vm.safeAddress.estado)
                } else {
                    Text("")
                }
            }
            
        }
    }
}

#Preview {
    let vm = HomePageVM()
      vm.address = ViaCepModel(cep: "57305752", logradouro: "Casinha do guilherme", complemento: "Arapiraca", unidade: "Alagoas", bairro: "não possui", localidade: "cavaco", uf: "nordeste", estado: "AL", regiao: "NE", ddd: "79")
      
      return ResultView(vm: vm)
    
}
