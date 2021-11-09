//
//  AuthView.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import SwiftUI

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

struct AuthView: View {
    let option: AuthOption
    var buttonTappedWithOption: (AuthButton) -> Void
    var changeOptionTapped: () -> Void
    
    private let buttonTextColor = Color(UIColor.systemBackground)
    private let buttonBackgroundColor = Color(UIColor.label)
    private let accentColor = UIColor(patternImage: UIImage(named: "hologram_1")!)

    
    var body: some View {
        VStack(alignment: .leading) {
            authWithButton(option: .phone)
            authWithButton(option: .email)
            authWithButton(option: .google)
            authWithButton(option: .facebook)
            authWithButton(option: .apple)
            
            Spacer()
            
            changeOptionText()
        }
        .padding(.vertical, 32)
    }
    
    func authWithButton(option: AuthButton) -> some View {
        Button {
            buttonTappedWithOption(option)
        } label: {
            HStack {
                option.buttonImage
                    .frame(width: 18, height: 18)
                    .foregroundColor(buttonTextColor)

                    .padding(.leading, 16)                
                authButtonText(title: option.title)
                    .foregroundColor(buttonTextColor)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .foregroundColor(Color(UIColor.systemBackground))
            .background(buttonBackgroundColor)
            .cornerRadius(8)
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 8)
    }
    
    func authButtonText(title: String) -> Text {
        switch option {
        case .login:
            return Text("Войти через " + title)
        case .signUp:
            return Text("Зарегистрироваться через " + title)
        }
    }
    
    func changeOptionText() -> some View {
        var questionText: String
        var solutionText: String

        switch option {
        case .login:
            questionText = "Впервые здесь?"
            solutionText = "Создать учетную запись"
        case .signUp:
            questionText = "У вас есть учетная запись?"
            solutionText = "Вход"
        }
        
        return HStack(alignment: .center) {
            Text(questionText)
                .foregroundColor(.primary)
            
            Button {
                changeOptionTapped()
            } label: {
                Text(solutionText)
                    .foregroundColor(Color(accentColor))
                    .fontWeight(.semibold)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 32)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(option: .signUp,
                 buttonTappedWithOption: { _ in }, changeOptionTapped: {})
    }
}
