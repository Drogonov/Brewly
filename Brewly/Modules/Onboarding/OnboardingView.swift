//
//  OnboardingView.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import SwiftUI

struct OnboardingView: View {
    
    var onboardingButtonTapped: () -> Void
    var mainTabBarButtonTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            VStack {
                Button {
                    onboardingButtonTapped()
                } label: {
                    Text("К логину")
                }
                .padding()
                Button {
                    mainTabBarButtonTapped()
                } label: {
                    Text("К главному контроллеру")
                }
                .padding()
            }
            Spacer()
        }
    }
}
