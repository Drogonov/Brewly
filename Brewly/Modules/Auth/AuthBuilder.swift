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
    func createAuthWithEmailModule(model: AuthWithEmailViewModel) -> UIViewController
}

class AuthModuleBuilder: AuthModuleBuilderProtocol {
    func createLoginModule(router: AuthRouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let presenter = AuthPresenter(
            loginView: view,
            router: router)
        
        view.presenter = presenter
        return view
    }
    
    func createSignUpModule(router: AuthRouterProtocol) -> UIViewController {
        let view = SignUpViewController()
        let presenter = AuthPresenter(
            signUpView: view,
            router: router
        )
        view.presenter = presenter
        return view
    }
    
    func createAuthWithEmailModule(model: AuthWithEmailViewModel) -> UIViewController {
        let view = AuthWithEmailViewController()
        let presenter = AuthWithEmailPresenter(
            view: view,
            model: model
        )
        view.presenter = presenter
        return view
    }
}
