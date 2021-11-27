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
        model: AuthModel
    ) -> UIViewController
    func createAuthWithOTPModule(
        router: AuthRouterProtocol,
        model: AuthModel
    ) -> UIViewController
}

class AuthModuleBuilder: AuthModuleBuilderProtocol {
    
    func createLoginModule(router: AuthRouterProtocol) -> UIViewController {
        let model = AuthModel(option: .login)
        let view = AuthViewController()
        let presenter = AuthPresenter(
            view: view,
            router: router,
            model: model
        )
        view.presenter = presenter
        return view
    }
    
    func createSignUpModule(router: AuthRouterProtocol) -> UIViewController {
        let model = AuthModel(option: .signUp)
        let view = AuthViewController()
        let presenter = AuthPresenter(
            view: view,
            router: router,
            model: model
        )
        view.presenter = presenter
        return view
    }
        
    func createAuthWithEmailModule(
        router: AuthRouterProtocol,
        model: AuthModel
    ) -> UIViewController {
        let view = AuthWithEmailViewController()
        let presenter = AuthWithEmailPresenter(
            view: view,
            router: router,
            model: model
        )
        view.presenter = presenter
        return view
    }
    
    func createAuthWithOTPModule(
        router: AuthRouterProtocol,
        model: AuthModel
    ) -> UIViewController {
        let view = AuthWithOTPViewController()
        let presenter = AuthWithOTPPresenter(
            view: view,
            router: router,
            model: model
        )
        view.presenter = presenter
        return view
    }
}
