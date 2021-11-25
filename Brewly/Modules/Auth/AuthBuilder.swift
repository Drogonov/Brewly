//
//  AuthBuilder.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit

protocol AuthModuleBuilderProtocol {
    func createLoginModule(router: AuthRouterProtocol) -> UIViewController
    func createSignUpModule(router: AuthRouterProtocol) -> UIViewController
    func createAuthWithEmailModule(
        router: AuthRouterProtocol,
        model: AuthWithEmailViewModel
    ) -> UIViewController
    func createAuthWithOTPModule(
        router: AuthRouterProtocol,
        model: AuthWithOTPViewModel
    ) -> UIViewController
}

class AuthModuleBuilder: AuthModuleBuilderProtocol {
    @Inject var authService: AuthService
    
    func createLoginModule(router: AuthRouterProtocol) -> UIViewController {
        let model = AuthViewModel(
            title: "Login",
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
        
        let view = AuthViewController()
        let presenter = AuthPresenter(
            view: view,
            router: router,
            model: model,
            authService: authService)
        
        view.presenter = presenter
        return view
    }
    
    func createSignUpModule(router: AuthRouterProtocol) -> UIViewController {
        let model = AuthViewModel(
            title: "Sign Up",
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
        
        let view = AuthViewController()
        let presenter = AuthPresenter(
            view: view,
            router: router,
            model: model,
            authService: authService
        )
        view.presenter = presenter
        return view
    }
    
    func createAuthWithEmailModule(
        router: AuthRouterProtocol,
        model: AuthWithEmailViewModel
    ) -> UIViewController {
        let view = AuthWithEmailViewController()
        let presenter = AuthWithEmailPresenter(
            view: view,
            router: router,
            model: model,
            authService: authService
        )
        view.presenter = presenter
        return view
    }
    
    func createAuthWithOTPModule(
        router: AuthRouterProtocol,
        model: AuthWithOTPViewModel
    ) -> UIViewController {
        let view = AuthWithOTPViewController()
        let presenter = AuthWithOTPPresenter(
            view: view,
            router: router,
            model: model,
            authService: authService
        )
        view.presenter = presenter
        return view
    }
}
