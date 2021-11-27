//
//  AuthPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import Foundation
import SwiftUI

protocol AuthPresenterProtocol: AnyObject {
    init(
        view: AuthViewProtocol,
        router: AuthRouterProtocol,
        model: AuthModel
    )
    func setAuthView()
    func showLogin()
    func showSignUp()
    func swipeLeft()
    func changeFlow(flow: FlowCase)
    func authButtonTappedWith(option: AuthOption, config: AuthButtonConfig, viewController: BaseViewController)
}

class AuthPresenter {
    
    // MARK: - Services
    
    @Inject var authService: AuthService
    
    // MARK: - Properties
    
    weak var view: AuthViewProtocol?
    var router: AuthRouterProtocol
    var model: AuthModel
    
    required init(
        view: AuthViewProtocol,
        router: AuthRouterProtocol,
        model: AuthModel
    ) {
        self.view = view
        self.router = router
        self.model = model
    }
}
// MARK: - AuthPresenterProtocol

extension AuthPresenter: AuthPresenterProtocol {
    func setAuthView() {
        let viewModel = configureViewModel()
        self.view?.setAuthView(with: viewModel)
    }
    
    func showLogin() {
        router.popViewController()
    }
        
    func showSignUp() {
        router.showSignUp()
    }
        
    func swipeLeft() {
        if model.option == .signUp {
            showLogin()
        }
    }
    
    func changeFlow(flow: FlowCase) {
        router.goToFlow(flow: flow)
    }
    
    func authButtonTappedWith(option: AuthOption, config: AuthButtonConfig, viewController: BaseViewController) {
        switch config {
        case .phone:
            showAuthWithOTP()
        case .email:
            showAuthWithEmail()
        case .google:
            showGoogleSignIn(with: viewController)
        case .facebook:
            debugPrint(config)
        case .apple:
            debugPrint(config)
        }
    }
}

// MARK: - Helper Functions

extension AuthPresenter {
    func configureViewModel() -> AuthViewModel {
        switch model.option {
        case .login:
            return AuthViewModel(
                navigationTitle: "Login",
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
        case .signUp:
            return AuthViewModel(
                navigationTitle: "Sign Up",
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
        }
    }
    
    func showAuthWithOTP() {
        router.showAuthWithOTP(model: model)
    }
    
    private func showAuthWithEmail() {
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
