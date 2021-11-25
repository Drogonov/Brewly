//
//  AuthViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 25.11.2021.
//

import UIKit
import SwiftUI

protocol AuthViewProtocol: AnyObject {
    func setAuthView(with model: AuthViewModel)
}

class AuthViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: AuthPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc override func handleSwipeLeftGesture(gesture: UISwipeGestureRecognizer) -> Void  {
        if gesture.direction == .left {
            self.presenter?.swipeLeft()
        }
    }
}

// MARK: - Configure UI

extension AuthViewController {
    private func configureUI() {
        presenter?.setAuthView()
    }
    
    private func configureView(with model: AuthViewModel) {
        let view = AuthView(
            model: model,
            buttonTappedWithConfig: { config in
                self.presenter?.authButtonTappedWith(option: model.option, config: config, viewController: self)
            }, changeOptionTapped: {
                self.changeOptionTapped(with: model)
            })
        addMainViewToViewController(view)
    }
        
    private func changeOptionTapped(with model: AuthViewModel) {
        switch model.option {
        case .login:
            self.presenter?.showSignUp()
        case .signUp:
            self.presenter?.showLogin()
        }
    }
}

// MARK: - LoginViewProtocol

extension AuthViewController: AuthViewProtocol {
    func setAuthView(with model: AuthViewModel) {
        setNavigationBarTitle(with: model.navigationTitle)
        configureView(with: model)
    }
}
