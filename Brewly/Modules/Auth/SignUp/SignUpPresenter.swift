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

    func setSignUpView() {
        self.view?.setSignUpView()
    }
}
