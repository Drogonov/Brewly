//
//  AuthPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import Foundation
import SwiftUI

protocol LoginPresenterProtocol: AnyObject {
    init(
        loginView: LoginViewProtocol,
        router: AuthRouterProtocol,
        authService: AuthServiceProtocol
    )
    func setLoginView()
    func showSignUp()
    func changeFlow(flow: FlowCase)
    func authButtonTappedWith(option: AuthOption, config: AuthButtonConfig, viewController: BaseViewController)
}

protocol SignUpPresenterProtocol: AnyObject {
    init(
        signUpView: SignUpViewProtocol,
        router: AuthRouterProtocol,
        authService: AuthServiceProtocol
    )
    func setSignUpView()
    func showLogin()
    func authButtonTappedWith(option: AuthOption, config: AuthButtonConfig, viewController: BaseViewController)
}

class AuthPresenter {
    
    // MARK: - Properties
    
    weak var loginView: LoginViewProtocol?
    weak var signUpView: SignUpViewProtocol?
    var authService: AuthServiceProtocol
    var router: AuthRouterProtocol
    
    required init(
        loginView: LoginViewProtocol,
        router: AuthRouterProtocol,
        authService: AuthServiceProtocol
    ) {
        self.loginView = loginView
        self.router = router
        self.authService = authService
    }
    
    required init(
        signUpView: SignUpViewProtocol,
        router: AuthRouterProtocol,
        authService: AuthServiceProtocol
    ) {
        self.signUpView = signUpView
        self.router = router
        self.authService = authService
    }
    
    func authButtonTappedWith(option: AuthOption, config: AuthButtonConfig, viewController: BaseViewController) {
        switch config {
        case .phone:
            debugPrint(config)
        case .email:
            showAuthWithEmail(with: option)
        case .google:
            showGoogleSignIn(with: viewController)
        case .facebook:
            debugPrint(config)
        case .apple:
            debugPrint(config)
        }
    }
}

// MARK: - LoginPresenterProtocol

extension AuthPresenter: LoginPresenterProtocol {
    func setLoginView() {
        let model = AuthViewModel(
            option: .login,
            buttonsArray: [
                AuthButtons.phone,
                AuthButtons.email,
                AuthButtons.google,
                AuthButtons.facebook,
                AuthButtons.apple
            ],
            authConfigButtonText: "Войти через",
            questionText: "Впервые здесь?",
            solutionText: "Создать учетную запись"
        )
        
        self.loginView?.setLoginView(with: model)
    }
    
    func showSignUp() {
        router.showSignUp()
    }
    
    func changeFlow(flow: FlowCase) {
        router.goToFlow(flow: flow)
    }
}

// MARK: - SignUpPresenterProtocol

extension AuthPresenter: SignUpPresenterProtocol {
    func showLogin() {
        router.popViewController()
    }
    
    func setSignUpView() {
        let model = AuthViewModel(
            option: .signUp,
            buttonsArray: [
                AuthButtons.phone,
                AuthButtons.email,
                AuthButtons.google,
                AuthButtons.facebook,
                AuthButtons.apple
            ],
            authConfigButtonText: "Регистрация через",
            questionText: "Уже есть аккаунт?",
            solutionText: "Вход"
        )
        self.signUpView?.setSignUpView(with: model)
    }
}

// MARK: - Helper Functions

extension AuthPresenter {
    private func showAuthWithEmail(with _option: AuthOption) {
        let navigationTitle: String
        let authButtonText: String
        
        switch _option {
        case .login:
            navigationTitle = "Вход"
            authButtonText = "Войти"
        case .signUp:
            navigationTitle = "Регистрация"
            authButtonText = "Зарегистрироваться"
        }
        
        let model = AuthWithEmailViewModel(
            option: _option,
            navigationTitle: navigationTitle,
            authButtonText: authButtonText
        )
        router.showAuthWithEmail(model: model)
    }
    
    func showGoogleSignIn(with viewController: BaseViewController) {
        authService.handleGoogleSignUp(viewController: viewController) { wasAuthSuccessful in
            if wasAuthSuccessful {
                self.router.routeToApp()
            } else {
                debugPrint("DEBUG: wasAuthSuccessful \(wasAuthSuccessful)")
            }
        }
    }
}
