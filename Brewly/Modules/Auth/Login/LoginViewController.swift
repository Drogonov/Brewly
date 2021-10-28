//
//  LoginViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit
import SwiftUI

protocol LoginViewProtocol: AnyObject {
    func setLoginView()
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: LoginPresenterProtocol!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .yellow
        configureLoginView()
    }
    
    private func configureLoginView() {
        let loginView = LoginView(loginButtonTapped: {
            self.presenter.changeFlow(flow: .onboarding)
        })
        addLoginViewToVC(loginView: loginView)
    }
    
    private func addLoginViewToVC(loginView: LoginView) {
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
    func setLoginView() {
        presenter.setLoginView()
    }
}
