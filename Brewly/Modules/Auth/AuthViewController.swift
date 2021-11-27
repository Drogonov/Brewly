//
//  AuthViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 25.11.2021.
//

import UIKit
import SwiftUI

protocol AuthViewProtocol: AnyObject {
    func setAuthView(with viewModel: AuthViewModel)
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
    
    private func configureView(with viewModel: AuthViewModel) {
        let view = AuthView(
            viewModel: viewModel,
            buttonTappedWithConfig: { config in
                self.presenter?.authButtonTappedWith(option: viewModel.option, config: config, viewController: self)
            }, changeOptionTapped: {
                self.changeOptionTapped(with: viewModel)
            })
        addMainViewToViewController(view)
    }
        
    private func changeOptionTapped(with viewModel: AuthViewModel) {
        switch viewModel.option {
        case .login:
            self.presenter?.showSignUp()
        case .signUp:
            self.presenter?.showLogin()
        }
    }
}

// MARK: - LoginViewProtocol

extension AuthViewController: AuthViewProtocol {
    func setAuthView(with viewModel: AuthViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}
