//
//  AuthWithEmailView.swift
//  Brewly
//
//  Created by Anton Vlezko on 17.11.2021.
//

import Foundation

import SwiftUI

struct AuthWithEmailView: View {
    
    // MARK: - Properties
    
    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    let model: AuthWithEmailViewModel
    var authButtonTapped: (String, String, String) -> Void
    
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

extension AuthWithEmailView {
    func textInputList() -> some View {
        List {
            if model.option == .signUp {
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(Color.primaryTextColor)
                    .frame(width: 32)
                    
                    TextField(
                        "userName",
                        text: $userName,
                        prompt: Text("Имя")
                    )
                }
            }
            
            HStack {
                Image(systemName: "mail")
                    .foregroundColor(Color.primaryTextColor)
                    .frame(width: 32)
                    .keyboardType(.emailAddress)
                
                TextField(
                    "email",
                    text: $email,
                    prompt: Text("Почта")
                )
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
            foregroundColor: Color.actionButtonTextColor,
            backgroundColor: Color.actionButtonBackgroundColor,
            action: {
                authButtonTapped(
                    userName,
                    email,
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

struct AuthWithEmail_Previews: PreviewProvider {
    static var previews: some View {
        AuthWithEmailView(
            model: AuthWithEmailViewModel(
                option: .signUp,
                navigationTitle: "Регистрация",
                authButtonText: "Зарегистрироваться"
            ),
            authButtonTapped: {_, _, _ in }
        )
    }
}