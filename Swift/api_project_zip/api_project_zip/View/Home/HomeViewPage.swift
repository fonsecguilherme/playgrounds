//
//  HomeViewPage.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 05/04/25.
//

import SwiftUI

struct HomeViewPage: View{
    
    @StateObject var vm = HomePageVM()
    
    var body: some View {
        
        Group {
            if vm.isLoading {
                ProgressView("Carregando...")
            } else if let message = vm.errorMessage {
                Text(message)
            }else {
                CustomCardView(logradouro: vm.safeAddress.logradouro, cep: vm.safeAddress.cep, cidade: String(vm.safeAddress.cep), estado: vm.safeAddress.estado)
                
            }
        }
        .onAppear {
            vm.fetchAddress(zip: 57305752);
        }
    }
}

#Preview {
    CustomCardView(
        logradouro: "Rua Teste",
        cep: "57305752",
        cidade: "Arapiraca",
        estado: "AL"
    )
}
