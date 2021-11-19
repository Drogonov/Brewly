//
//  AuthWithEmailPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 17.11.2021.
//

import Foundation

protocol AuthWithEmailPresenterProtocol: AnyObject {
    init(
        view: AuthWithEmailViewProtocol,
        router: AuthRouterProtocol,
        model: AuthWithEmailViewModel,
        authService: AuthServiceProtocol
    )
    func setAuthWithEmailView()
    func authWithData(
        fullname: String,
        email: String,
        password: String
    )
}

class AuthWithEmailPresenter: AuthWithEmailPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: AuthWithEmailViewProtocol?
    var router: AuthRouterProtocol
    var model: AuthWithEmailViewModel
    var authService: AuthServiceProtocol
    
    // MARK: - Construction
    
    required init(
        view: AuthWithEmailViewProtocol,
        router: AuthRouterProtocol,
        model: AuthWithEmailViewModel,
        authService: AuthServiceProtocol
    ) {
        self.view = view
        self.router = router
        self.model = model
        self.authService = authService
    }
    
    // MARK: - Protocol Functions
    
    func setAuthWithEmailView() {
        self.view?.setAuthWithEmailView(with: model)
    }
    
    func authWithData(
        fullname: String,
        email: String,
        password: String
    ) {
        view?.showLoader()
        switch model.option {
        case .login:
            authService.handleLogin(
                email: email,
                password: password,
                completion: { wasLoginSuccessful in
                    self.view?.hideLoader()
                    if wasLoginSuccessful == true {
                        self.router.routeToApp()
                    } else {
                        
                    }
                }
            )
        case .signUp:
            authService.handleSignUp(
                fullname: fullname,
                email: email,
                password: password,
                completion: { wasSignUpSuccessful in
                    self.view?.hideLoader()
                    if wasSignUpSuccessful == true {
                        self.router.routeToApp()
                    } else {
                        
                    }
                }
            )
        }
    }
}
