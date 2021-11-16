//
//  AuthView.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import SwiftUI

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
}

extension AuthView {
    func authWithButton(option: AuthButton) -> some View {
        ActionButton(
            foregroundColor: buttonTextColor,
            backgroundColor: buttonBackgroundColor,
            action: {
                buttonTappedWithOption(option)
            },
            content: {
                Image(systemName: option.buttonImageName)
                Text(authButtonText(title: option.title))
            }
        )
            .padding(.horizontal, 32)
            .padding(.vertical, 8)
    }
    
    func authButtonText(title: String) -> String {
        switch option {
        case .login:
            return "Войти через " + title
        case .signUp:
            return "Зарегистрироваться через " + title
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
                    .foregroundColor(.red)
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
