//
//  AuthEnums.swift
//  Brewly
//
//  Created by Anton Vlezko on 15.11.2021.
//

import UIKit

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
    
    var buttonImage: Image {
        switch self {
        case .phone:
            return Image(systemName: "phone")
        case .email:
            return Image(systemName: "mail")
        case .google:
            return Image(systemName: "g.circle")
        case .facebook:
            return Image(systemName: "f.circle")
        case .apple:
            return Image(systemName: "applelogo")
        }
    }
}
