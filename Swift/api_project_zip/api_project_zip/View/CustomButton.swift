//
//  CustomButton.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 06/04/25.
//

import SwiftUI

struct CustomButton: View {
    
    let zipValue: String
    let buttonTextLabel: String
    let vm: HomePageVM
    
    
    var body: some View {
        Button(buttonTextLabel, systemImage: "arrow.right.circle") {
            vm.fetchAddress(zip: zipValue)
        }
        .buttonStyle(.bordered)
        .background(.purple)
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .tint(.white)
        .padding()
    }
}

#Preview{
    CustomButton(zipValue:"123456789", buttonTextLabel: "Procurar...", vm: HomePageVM())
}
