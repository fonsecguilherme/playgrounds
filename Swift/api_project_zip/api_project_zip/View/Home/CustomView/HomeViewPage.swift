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
        CustomCardView(logradouro: vm.address?.logradouro ?? "", cep: vm.address?.cep ?? "", cidade: String(vm.address?.cep ?? ""), estado: vm.address?.estado ?? "")
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
