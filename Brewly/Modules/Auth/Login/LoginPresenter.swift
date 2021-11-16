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

struct AuthViewModel {
    var option: AuthOption
    var authButtonText: String
    var questionText: String
    var solutionText: String
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
//        let option: AuthOption = .login
//        let authButtonText: String = "Войти через " + option.title
//        let questionText: String = "Впервые здесь?"
//        let solutionText: String = "Создать учетную запись"
        
        self.view?.setLoginView()
    }
    
    func showSignUp() {
        router.showSignUp()
    }
    
    func changeFlow(flow: FlowCase) {
        router.goToFlow(flow: flow)
    }
}
