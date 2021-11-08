//
//  BrewConfigurationView.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import SwiftUI

struct BrewConfigurationView: View {
    @State private var cappingName: String = ""
    @State private var amountOfSamples: Int?
    @State private var comment: String = ""
    
    let createBrewTapped: () -> Void

    var body: some View {
        let bindingAmountOfSamples = Binding<String>(
            get: { self.amountOfSamples?.numberToString ?? "" },
            set: { self.amountOfSamples = $0.stringToNumber ?? 0 }
        )
        
        VStack(spacing: 32) {
            List {
                TextField("cappingName",
                          text: $cappingName,
                          prompt: Text("Capping Name"))
                
                TextField("amountOfSamples",
                          text: bindingAmountOfSamples,
                          prompt: Text("Amount of Samples"))
                    .keyboardType(.numberPad)
                
                TextField("comment",
                          text: $comment,
                          prompt: Text("Comment"))
                            
            }
                        
            Button {
                createBrewTapped()
            } label: {
                Text("Lets brew!")
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color(UIColor.label))
                    .foregroundColor(Color(UIColor.systemBackground))
                    .cornerRadius(8)
                    .padding(.horizontal, 64)
            }
        }
        .padding(.bottom, 32)
    }
}

struct BrewConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        BrewConfigurationView(createBrewTapped: {})
    }
}