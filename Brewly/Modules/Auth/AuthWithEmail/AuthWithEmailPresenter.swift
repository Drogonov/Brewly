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
}

class AuthWithEmailPresenter: AuthWithEmailPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: AuthWithEmailViewProtocol?
    var model: AuthWithEmailViewModel
    
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
}
