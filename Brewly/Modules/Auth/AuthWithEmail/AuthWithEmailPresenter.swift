//
//  AuthWithEmailPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 17.11.2021.
//

import Foundation

protocol AuthWithEmailPresenterProtocol: AnyObject {
    init(view: AuthWithEmailViewProtocol,
         model: AuthWithEmailViewModel)
    func setAuthWithEmailView()
    func signUp(userName: String,
                email: String,
                password: String)
}

class AuthWithEmailPresenter: AuthWithEmailPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: AuthWithEmailViewProtocol?
    var model: AuthWithEmailViewModel
    let authService = AuthService(dataUploader: DataUploader())
    
    // MARK: - Construction
    
    required init(
        view: AuthWithEmailViewProtocol,
        model: AuthWithEmailViewModel
    ) {
        self.view = view
        self.model = model
    }
    
    // MARK: - Protocol Functions
    
    func setAuthWithEmailView() {
        self.view?.setAuthWithEmailView(with: model)
    }
    
    func signUp(userName: String,
                email: String,
                password: String) {
        authService.handleSignUp(email: email,
                                 password: password) { wasUserSignUp in
            debugPrint(wasUserSignUp)
        }
    }
}
