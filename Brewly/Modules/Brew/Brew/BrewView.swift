//
//  BrewView.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import SwiftUI

struct BrewView: View {
    
    let brewButtonText: String
    let brewButtonTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Image("CoffeeBG")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            ActionButton(
                action: {
                    brewButtonTapped()
                },
                content: {
                    Text(brewButtonText)
                }
            )
        }
        .padding(.horizontal, 64)
        .padding(.vertical, 32)
    }
}

struct BrewView_Previews: PreviewProvider {
    static var previews: some View {
        BrewView(
            brewButtonText: "Lets Brew!",
            brewButtonTapped: {}
        )
    }
}
