//
//  ResultView.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 20/04/25.
//

import SwiftUI

struct ResultView: View {    
    let address: AddressModel
    
    var body: some View {
        VStack {
            CustomCardView(logradouro: address.logradouro, cep: address.cep, cidade: String(address.cep), estado: address.estado)
                .padding()
        }
    }
}
