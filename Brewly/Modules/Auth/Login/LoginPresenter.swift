//
//  LoginPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import Foundation
import SwiftUI

protocol LoginPresenterProtocol: AnyObject {
    init(view: LoginViewProtocol,
         router: AuthRouterProtocol)
    
    func setLoginView()
    func showSignUp()
    func changeFlow(flow: FlowCase)
}

class LoginPresenter: LoginPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: LoginViewProtocol?
    var router: AuthRouterProtocol
    
    // MARK: - Init
    
    required init(view: LoginViewProtocol,
                  router: AuthRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Protocol Functions
    
    func setLoginView() {
        let model = AuthViewModel(
            option: .login,
            buttonsArray: [
                .phone,
                .email,
                .google,
                .facebook,
                .apple
            ],
            questionText: "Впервые здесь?",
            solutionText: "Создать учетную запись"
        )
        
        self.view?.setLoginView(with: model)
    }
    
    func showSignUp() {
        router.showSignUp()
    }
    
    func changeFlow(flow: FlowCase) {
        router.goToFlow(flow: flow)
    }
}
