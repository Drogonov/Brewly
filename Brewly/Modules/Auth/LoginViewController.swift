//
//  LoginViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit
import SwiftUI

protocol LoginViewProtocol: AnyObject {
    func setLoginView(with model: AuthViewModel)
}

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: LoginPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc override func handleSwipeLeftGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .left {
            self.presenter?.showSignUp()
        }
    }
}

// MARK: - Configure UI

extension LoginViewController {
    private func configureUI() {
        setNavigationBarTitle(with: "Login")
        presenter?.setLoginView()
    }
    
    private func configureView(with model: AuthViewModel) {
        let view = AuthView(
            model: model,
            buttonTappedWithConfig: { config in
                self.presenter?.authButtonTappedWith(option: model.option, config: config, viewController: self)
            }, changeOptionTapped: {
                self.presenter?.showSignUp()
            })
        addMainViewToViewController(view)
    }
}

// MARK: - LoginViewProtocol

extension LoginViewController: LoginViewProtocol {
    func setLoginView(with model: AuthViewModel) {
        configureView(with: model)
    }
}
