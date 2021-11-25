//
//  AuthViewModel.swift
//  Brewly
//
//  Created by Anton Vlezko on 17.11.2021.
//

import Foundation

struct AuthViewModel {
    let navigationTitle: String
    let option: AuthOption
    let buttonsArray: [AuthButtonViewModel]
    let authConfigButtonText: String
    let questionText: String
    let solutionText: String
}

struct AuthButtonViewModel: Hashable {
    let id = UUID()
    let config: AuthButtonConfig
    let title: String
    let buttonImageName: String
}

struct AuthWithEmailViewModel {
    let option: AuthOption
    let navigationTitle: String
    let authButtonText: String
}

struct AuthWithOTPViewModel {
    let option: AuthOption
    let navigationTitle: String
    let authButtonText: String
}

struct AuthButtons {
    static let phone = AuthButtonViewModel(
        config: .phone,
        title: "номер телефона",
        buttonImageName: "phone"
    )
    
    static let email = AuthButtonViewModel(
        config: .email,
        title: "эл. почту",
        buttonImageName: "mail"
    )
    
    static let google = AuthButtonViewModel(
        config: .google,
        title: "Google",
        buttonImageName: "g.circle"
    )
    
    static let facebook = AuthButtonViewModel(
        config: .facebook,
        title: "Facebook",
        buttonImageName: "f.circle"
    )
    
    static let apple = AuthButtonViewModel(
        config: .apple,
        title: "Apple",
        buttonImageName: "applelogo"
    )
}
