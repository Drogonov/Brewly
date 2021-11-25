//
//  AuthWithOTPView.swift
//  Brewly
//
//  Created by Anton Vlezko on 24.11.2021.
//

import Foundation
import SwiftUI

struct AuthWithOTPView: View {
    
    // MARK: - Properties
    
    @State private var phone: String = ""
    @State private var password: String = ""
    
    let model: AuthWithOTPViewModel
    var authButtonTapped: (String, String) -> Void
    
    // MARK: - Construction
    
    var body: some View {
        VStack(spacing: 32) {
            textInputList()
            authButton()
        }
        .padding(.vertical, 32)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

// MARK: - Helper Functions

extension AuthWithOTPView {
    func textInputList() -> some View {
        List {
            HStack {
                Image(systemName: "phone")
                    .foregroundColor(Color.primaryTextColor)
                    .frame(width: 32)
                
                TextField(
                    "phone",
                    text: $phone,
                    prompt: Text("Телефон")
                )
                    .keyboardType(.emailAddress)
                
            }
            
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(Color.primaryTextColor)
                    .frame(width: 32)
                
                SecureField(
                    "password",
                    text: $password,
                    prompt: Text("Пароль")
                )
            }
        }
    }
    
    func authButton() -> some View {
        ActionButton(
            action: {
                authButtonTapped(
                    phone,
                    password
                )
            },
            content: {
                Text(model.authButtonText)
                    .padding(.horizontal, 8)
            }
        )
            .padding(.horizontal, 32)
            .padding(.vertical, 8)
    }
}

// MARK: - AuthView_Previews

struct AuthWithOTPView_Previews: PreviewProvider {
    static var previews: some View {
        AuthWithOTPView(
            model: AuthWithOTPViewModel(
                option: .signUp,
                navigationTitle: "Регистрация",
                authButtonText: "Зарегистрироваться"
            ),
            authButtonTapped: {_, _ in }
        )
    }
}
