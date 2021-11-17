//
//  SignUpPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import Foundation

protocol SignUpPresenterProtocol: AnyObject {
    init(view: SignUpViewProtocol,
         router: AuthRouterProtocol)
    func setSignUpView()
    func showLogin()
}

class SignUpPresenter: SignUpPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: SignUpViewProtocol?
    var router: AuthRouterProtocol
        
    // MARK: - Init

    required init(view: SignUpViewProtocol,
                  router: AuthRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Protocol Functions
    
    func showLogin() {
        router.popViewController()
    }

    func setSignUpView() {
        let model = AuthViewModel(
            option: .signUp,
            buttonsArray: [
                .phone,
                .email,
                .google,
                .facebook,
                .apple
            ],
            questionText: "Уже есть аккаунт?",
            solutionText: "Вход"
        )
        self.view?.setSignUpView(with: model)
    }
}
