//
//  LoginViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit
import SwiftUI

protocol LoginViewProtocol: AnyObject {
    func setLoginView(with _model: AuthViewModel)
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: LoginPresenterProtocol?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Configure UI

extension LoginViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        presenter?.setLoginView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Login"
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        let color = UIColor(patternImage: UIImage(named: "hologram_1")!)
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.red]
    }
        
    private func configureLoginView(with _model: AuthViewModel) {
        let loginView = AuthView(
            model: _model,
            buttonTappedWithConfig: { config in
                
            }, changeOptionTapped: {
                self.presenter?.showSignUp()
            })
        addLoginViewToVC(loginView: loginView)
    }
    
    private func addLoginViewToVC(loginView: AuthView) {
        let loginCtrl = UIHostingController(rootView: loginView)
        addChild(loginCtrl)
        view.addSubview(loginCtrl.view)
        
        loginCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

// MARK: - LoginViewProtocol

extension LoginViewController: LoginViewProtocol {
    func setLoginView(with _model: AuthViewModel) {
        configureLoginView(with: _model)
    }
}
