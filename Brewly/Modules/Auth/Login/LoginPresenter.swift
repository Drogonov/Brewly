//
//  LoginPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import Foundation

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
        self.view?.setLoginView()
    }
    
    func showSignUp() {
        router.showSignUp()
    }
    
    func changeFlow(flow: FlowCase) {
        router.goToFlow(flow: flow)
    }
}
