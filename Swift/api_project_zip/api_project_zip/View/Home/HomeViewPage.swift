//
//  HomeViewPage.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 05/04/25.
//

import SwiftUI

struct HomeViewPage: View{
    
    @State private var zipValue: String = ""
    @StateObject var vm = HomePageVM()
    let textFieldLimit: Int = 8
    
    
    var body: some View {
        VStack{
            Text("Home Page view!")
            TextField(
                "Digite o CEP a ser pesquisado",
                text: $zipValue
            )
            .keyboardType(.numberPad)
            .textFieldStyle(.roundedBorder)
            .padding(
                .horizontal, 20
            )
            .onChange(of: zipValue) {
                if zipValue.count > textFieldLimit{
                    zipValue = String(zipValue.prefix(textFieldLimit))
                }
            }
            Text("\(zipValue.count)/\(textFieldLimit)")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 20)
            
            CustomButton(zipValue: zipValue,buttonTextLabel: "Procurar..." ,vm: vm)
            
            Group {
                if vm.isLoading {
                    ProgressView("Carregando...")
                } else if let message = vm.errorMessage {
                    Text(message)
                } else if vm.address != nil {
                    ResultView(vm: vm)
                } else {
                    Text("")
                }
            }
            
        }
    }
}

#Preview {
//    let vm = HomePageVM()
//      vm.address = ViaCepModel(cep: "57305752", logradouro: "Casinha do guilherme", complemento: "Arapiraca", unidade: "Alagoas", bairro: "não possui", localidade: "cavaco", uf: "nordeste", estado: "AL", regiao: "NE", ddd: "79")
//      
//      return ResultView(vm: vm)
    
    HomeViewPage().body
    
}
