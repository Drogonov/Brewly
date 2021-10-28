//
//  LoginView.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import SwiftUI

struct LoginView: View {
    
    var loginButtonTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Button {
                loginButtonTapped()
            } label: {
                Text("К онбоардингу")
            }
            Spacer()
        }
    }
}
