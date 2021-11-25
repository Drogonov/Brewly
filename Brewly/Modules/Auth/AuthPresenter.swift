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
        model: AuthViewModel,
        authService: AuthServiceProtocol
    )
    func setAuthView()
    func showLogin()
    func showSignUp()
    func swipeRight()
    func swipeLeft()
    func changeFlow(flow: FlowCase)
    func authButtonTappedWith(option: AuthOption, config: AuthButtonConfig, viewController: BaseViewController)
}

class AuthPresenter {
    
    // MARK: - Properties
    
    weak var view: AuthViewProtocol?
    var authService: AuthServiceProtocol
    var router: AuthRouterProtocol
    var model: AuthViewModel
        
    required init(
        view: AuthViewProtocol,
        router: AuthRouterProtocol,
        model: AuthViewModel,
        authService: AuthServiceProtocol
    ) {
        self.view = view
        self.router = router
        self.model = model
        self.authService = authService
    }
}
// MARK: - AuthPresenterProtocol

extension AuthPresenter: AuthPresenterProtocol {
    func setAuthView() {
        self.view?.setAuthView(with: model)
    }
    
    func showLogin() {
        router.popViewController()
    }
        
    func showSignUp() {
        router.showSignUp()
    }
    
    func swipeRight() {
        if model.option == .login {
            router.showSignUp()
        }
    }
    
    func swipeLeft() {
        if model.option == .signUp {
            router.showLogin()
        }
    }
    
    func changeFlow(flow: FlowCase) {
        router.goToFlow(flow: flow)
    }
    
    func authButtonTappedWith(option: AuthOption, config: AuthButtonConfig, viewController: BaseViewController) {
        switch config {
        case .phone:
            showAuthWithOTP(with: option)
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

// MARK: - Helper Functions

extension AuthPresenter {
    func showAuthWithOTP(with option: AuthOption) {
        let navigationTitle: String
        let authButtonText: String
        
        switch option {
        case .login:
            navigationTitle = "Вход"
            authButtonText = "Войти"
        case .signUp:
            navigationTitle = "Регистрация"
            authButtonText = "Зарегистрироваться"
        }
        
        let model = AuthWithOTPViewModel(
            option: option,
            navigationTitle: navigationTitle,
            authButtonText: authButtonText
        )
        router.showAuthWithOTP(model: model)
        
    }
    
    private func showAuthWithEmail(with option: AuthOption) {
        let navigationTitle: String
        let authButtonText: String
        
        switch option {
        case .login:
            navigationTitle = "Вход"
            authButtonText = "Войти"
        case .signUp:
            navigationTitle = "Регистрация"
            authButtonText = "Зарегистрироваться"
        }
        
        let model = AuthWithEmailViewModel(
            option: option,
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
