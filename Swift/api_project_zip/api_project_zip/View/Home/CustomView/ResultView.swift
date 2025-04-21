//
//  ResultView.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 20/04/25.
//

import SwiftUI

struct ResultView: View {    
    let vm: HomePageVM
    
    var body: some View {
        VStack {
            CustomCardView(logradouro: vm.safeAddress.logradouro, cep: vm.safeAddress.cep, cidade: String(vm.safeAddress.cep), estado: vm.safeAddress.estado)
                .padding()
        }
    }
}
