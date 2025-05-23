//
//  CustomCardView.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 05/04/25.
//

import SwiftUI

struct CustomCardView: View {
    let logradouro: String
    let cep: String
    let cidade: String
    let estado: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(cep)")
                .font(.system(size: 18.0, weight: .bold))
            Text(logradouro)
            Text("\(cidade) - \(estado)")
        }
        .padding(16.0)
        .background(Color.purple)
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .overlay(RoundedRectangle(cornerRadius: 20.0)
            .stroke(Color.gray  , lineWidth: 4)
        )
    }
}
