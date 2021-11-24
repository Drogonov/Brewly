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
        model: AuthWithOTPViewModel,
        authService: AuthServiceProtocol
    )
    func setAuthWithOTPView()
    func authWithData(
        phone: String,
        password: String
    )
}

class AuthWithOTPPresenter: AuthWithOTPPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: AuthWithOTPViewProtocol?
    var router: AuthRouterProtocol
    var model: AuthWithOTPViewModel
    var authService: AuthServiceProtocol
    
    // MARK: - Construction
    
    required init(
        view: AuthWithOTPViewProtocol,
        router: AuthRouterProtocol,
        model: AuthWithOTPViewModel,
        authService: AuthServiceProtocol
    ) {
        self.view = view
        self.router = router
        self.model = model
        self.authService = authService
    }
    
    // MARK: - Protocol Functions
    
    func setAuthWithOTPView() {
        self.view?.setAuthWithOTPView(with: model)
    }
    
    func authWithData(
        phone: String,
        password: String
    ) {
        view?.showLoader()
        sleep(2)
        view?.hideLoader()
    }
}
