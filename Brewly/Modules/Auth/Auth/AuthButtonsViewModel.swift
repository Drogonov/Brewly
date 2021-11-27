//
//  AuthButtonsViewModel.swift
//  Brewly
//
//  Created by Anton Vlezko on 27.11.2021.
//

import Foundation

struct AuthButtonViewModel: Hashable {
    let id = UUID()
    let config: AuthButtonConfig
    let title: String
    let buttonImageName: String
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
