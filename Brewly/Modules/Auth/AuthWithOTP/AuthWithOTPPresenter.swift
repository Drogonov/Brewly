//
//  AuthWithOTPPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 24.11.2021.
//

import Foundation

protocol AuthWithOTPPresenterProtocol: AnyObject {
    init(
        view: AuthWithOTPViewProtocol,
        router: AuthRouterProtocol,
        model: AuthModel
    )
    func setAuthWithOTPView()
    func authWithData(with tuple: (phone: String, password: String))
}

class AuthWithOTPPresenter: AuthWithOTPPresenterProtocol {
    
    // MARK: - Services
    
    @Inject var authService: AuthService
    
    // MARK: - Properties
    
    weak var view: AuthWithOTPViewProtocol?
    var router: AuthRouterProtocol
    var model: AuthModel
    
    // MARK: - Construction
    
    required init(
        view: AuthWithOTPViewProtocol,
        router: AuthRouterProtocol,
        model: AuthModel
    ) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    // MARK: - Protocol Functions
    
    func setAuthWithOTPView() {
        let viewModel = configureViewModel()
        self.view?.setAuthWithOTPView(with: viewModel)
    }
    
    func authWithData(with tuple: (phone: String, password: String)) {
        view?.showLoader()
        sleep(2)
        view?.hideLoader()
    }
}

// MARK: - Helper Functions

extension AuthWithOTPPresenter {
    func configureViewModel() -> AuthWithOTPViewModel {
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
        
        return AuthWithOTPViewModel(
            option: model.option,
            navigationTitle: navigationTitle,
            authButtonText: authButtonText
        )
    }
}
