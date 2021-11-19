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
}

class AuthModuleBuilder: AuthModuleBuilderProtocol {
    func createLoginModule(router: AuthRouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let authService = AuthService(dataUploader: DataUploader())
        let presenter = AuthPresenter(
            loginView: view,
            router: router,
            authService: authService)
        
        view.presenter = presenter
        return view
    }
    
    func createSignUpModule(router: AuthRouterProtocol) -> UIViewController {
        let view = SignUpViewController()
        let authService = AuthService(dataUploader: DataUploader())
        let presenter = AuthPresenter(
            signUpView: view,
            router: router,
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
        let authService = AuthService(dataUploader: DataUploader())
        let presenter = AuthWithEmailPresenter(
            view: view,
            router: router,
            model: model,
            authService: authService
        )
        view.presenter = presenter
        return view
    }
}
