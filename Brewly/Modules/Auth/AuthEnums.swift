//
//  AuthEnums.swift
//  Brewly
//
//  Created by Anton Vlezko on 15.11.2021.
//

import Foundation

enum AuthOption {
    case login
    case signUp
}

enum AuthButton {
    case phone
    case email
    case google
    case facebook
    case apple
    
    var title: String {
        switch self {
        case .phone:
            return "номер телефона"
        case .email:
            return "эл. почту"
        case .google:
            return "Google"
        case .facebook:
            return "Facebook"
        case .apple:
            return "Apple"
        }
    }
    
    var buttonImageName: String {
        switch self {
        case .phone:
            return "phone"
        case .email:
            return "mail"
        case .google:
            return "g.circle"
        case .facebook:
            return "f.circle"
        case .apple:
            return "applelogo"
        }
    }
}
