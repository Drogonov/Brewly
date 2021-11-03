//
//  BrewView.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import SwiftUI

struct BrewView: View {
    
    let brewButtonTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Image("CoffeeBG")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Button {
                brewButtonTapped()
            } label: {
                Text("Lets brew!")
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color(UIColor.label))
                    .foregroundColor(Color(UIColor.systemBackground))
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 64)
        .padding(.vertical, 32)
    }
}

struct BrewView_Previews: PreviewProvider {
    static var previews: some View {
        BrewView(brewButtonTapped: {})
    }
}
