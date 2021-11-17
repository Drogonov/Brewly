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
    var buttonTappedWithConfig: (AuthButton) -> Void
    var changeOptionTapped: () -> Void
    
    private let buttonTextColor = Color(UIColor.systemBackground)
    private let buttonBackgroundColor = Color(UIColor.label)
    private let accentColor = Color(.red)
    
    // MARK: - Construction
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(model.buttonsArray, id: \.self) { config in
                authWithButton(config: config)
            }
            Spacer()
            changeOptionText()
        }
        .padding(.vertical, 32)
    }
}

// MARK: - Helper Functions

extension AuthView {
    func authWithButton(config: AuthButton) -> some View {
        ActionButton(
            foregroundColor: buttonTextColor,
            backgroundColor: buttonBackgroundColor,
            action: {
                buttonTappedWithConfig(config)
            },
            content: {
                HStack {
                    Image(systemName: config.buttonImageName)
                    Text(model.option.buttonText + " " + config.title)
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
                    .foregroundColor(accentColor)
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
                option: .signUp,
                buttonsArray: [
                    .phone,
                    .email,
                    .google,
                    .facebook,
                    .apple
                ],
                questionText: "Впервые здесь?",
                solutionText: "Создать учетную запись"
            ),
            buttonTappedWithConfig: { _ in },
            changeOptionTapped: {}
        )
    }
}
