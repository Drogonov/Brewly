//
//  OnboardingView.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import SwiftUI

struct OnboardingView: View {
    
    var onboardingButtonTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Button {
                onboardingButtonTapped()
            } label: {
                Text("К логину")
            }
            Spacer()
        }
    }
}
