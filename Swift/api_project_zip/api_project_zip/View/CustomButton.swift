//
//  CustomButton.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 06/04/25.
//

import SwiftUI

struct CustomButton: View {
    
    let zipValue: String
    let vm: HomePageVM
    
    
    var body: some View {
        Button("Procurar...", systemImage: "arrow.right.circle") {
            if let zipInt = Int(zipValue) {
                
                print("inteiro")
                vm.fetchAddress(zip: zipInt)
            } else {
                print("inteiro")
                vm.errorMessage = "CEP inválido"
            }
        }
        .buttonStyle(.bordered)
        .background(.purple)
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .tint(.white)
        .padding()
        
//        Button {
//            if let zipInt = Int(zipValue) {
////                   vm.fetchAddress(zip: zipInt)
//               } else {
////                   vm.errorMessage = "CEP inválido"
//               }
//        } label: {
//            Label("Procurar...", systemImage: "arrow.right.circle")
//                .buttonStyle(.bordered)
//                .background(.purple)
//                .tint(.white)
//        }
    }
}

#Preview{
    CustomButton(zipValue:"123456789", vm: HomePageVM())
}
