//
//  SignUpViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit
import SwiftUI

protocol SignUpViewProtocol: AnyObject {
    func setSignUpView(with _model: AuthViewModel)
}

class SignUpViewController: UIViewController {
    
    // MARK: - Properties

    var presenter: SignUpPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        presenter?.setSignUpView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Sign Up"
    }
    
    private func configureSignUpView(with _model: AuthViewModel) {
        let signUpView = AuthView(
            model: _model,
            buttonTappedWithConfig: { config in
                
            }, changeOptionTapped: {
                self.presenter?.showLogin()
            })
        addSignUpViewToVC(signUpView: signUpView)
    }
    
    private func addSignUpViewToVC(signUpView: AuthView) {
        let signUpCtrl = UIHostingController(rootView: signUpView)
        addChild(signUpCtrl)
        view.addSubview(signUpCtrl.view)
        
        signUpCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

// MARK: - SignUpViewProtocol

extension SignUpViewController: SignUpViewProtocol {
    func setSignUpView(with _model: AuthViewModel) {
        configureSignUpView(with: _model)
    }
}
