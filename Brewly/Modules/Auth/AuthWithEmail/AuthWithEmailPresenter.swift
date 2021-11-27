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
        model: AuthModel
    )
    func setAuthWithEmailView()
    func authWithData(with tuple: (fullname: String, email: String, password: String))
}

class AuthWithEmailPresenter: AuthWithEmailPresenterProtocol {
    
    // MARK: - Services
    
    @Inject var authService: AuthService
    
    // MARK: - Properties
    
    weak var view: AuthWithEmailViewProtocol?
    var router: AuthRouterProtocol
    var model: AuthModel
    
    // MARK: - Construction
    
    required init(
        view: AuthWithEmailViewProtocol,
        router: AuthRouterProtocol,
        model: AuthModel
    ) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    // MARK: - Protocol Functions
    
    func setAuthWithEmailView() {
        let viewModel = configureViewModel()
        self.view?.setAuthWithEmailView(with: viewModel)
    }
    
    func authWithData(with tuple: (fullname: String, email: String, password: String)) {
        view?.showLoader()
        switch model.option {
        case .login:
            authService.handleLogin(
                email: tuple.email,
                password: tuple.password,
                completion: { wasAuthSuccessful in
                    self.view?.hideLoader()
                    if wasAuthSuccessful == true {
                        self.router.routeToApp()
                    } else {
                        debugPrint("DEBUG: wasAuthSuccessful \(wasAuthSuccessful)")
                    }
                }
            )
        case .signUp:
            authService.handleSignUp(
                fullname: tuple.fullname,
                email: tuple.email,
                password: tuple.password,
                completion: { wasAuthSuccessful in
                    self.view?.hideLoader()
                    if wasAuthSuccessful == true {
                        self.router.routeToApp()
                    } else {
                        debugPrint("DEBUG: wasAuthSuccessful \(wasAuthSuccessful)")
                    }
                }
            )
        }
    }
}

// MARK: - Helper Functions

extension AuthWithEmailPresenter {
    func configureViewModel() -> AuthWithEmailViewModel {
        let navigationTitle: String
        let authButtonText: String
        
        switch model.option {
        case .login:
            navigationTitle = "Вход"
            authButtonText = "Войти"
        case .signUp:
            navigationTitle = "Регистрация"
            authButtonText = "Зарегистрироваться"
        }
        
        return AuthWithEmailViewModel(
            option: model.option,
            navigationTitle: navigationTitle,
            authButtonText: authButtonText
        )
    }
}
