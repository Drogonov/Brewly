//
//  AuthView.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import SwiftUI

struct AuthView: View {
    
    // MARK: - Properties
    
    let model: AuthViewModel
    var buttonTappedWithConfig: (AuthButtonConfig) -> Void
    var changeOptionTapped: () -> Void
    
    // MARK: - Construction
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(model.buttonsArray, id: \.id) { buttonModel in
                authWithButton(with: buttonModel)
            }
            Spacer()
            changeOptionText()
        }
        .padding(.vertical, 32)
    }
}

// MARK: - Helper Functions

extension AuthView {
    func authWithButton(with buttonModel: AuthButtonViewModel) -> some View {
        ActionButton(
            foregroundColor: Color.actionButtonTextColor,
            backgroundColor: Color.actionButtonBackgroundColor,
            action: {
                buttonTappedWithConfig(buttonModel.config)
            },
            content: {
                HStack {
                    Image(systemName: buttonModel.buttonImageName)
                    Text(model.authConfigButtonText + " " + buttonModel.title)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.horizontal, 8)
            }
        )
            .padding(.horizontal, 32)
            .padding(.vertical, 8)
    }
    
    func changeOptionText() -> some View {
        HStack(alignment: .center) {
            Text(model.questionText)
                .foregroundColor(.primary)
            
            Button {
                changeOptionTapped()
            } label: {
                Text(model.solutionText)
                    .foregroundColor(Color.accentColor)
                    .fontWeight(.semibold)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 32)
    }
}

// MARK: - AuthView_Previews

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(
            model: AuthViewModel(
                title: "Login",
                option: .signUp,
                buttonsArray: [
                    AuthButtons.phone,
                    AuthButtons.email,
                    AuthButtons.google,
                    AuthButtons.facebook,
                    AuthButtons.apple
                ],
                authConfigButtonText: "Регистрация через",
                questionText: "Впервые здесь?",
                solutionText: "Создать учетную запись"
            ),
            buttonTappedWithConfig: { _ in },
            changeOptionTapped: {}
        )
    }
}
