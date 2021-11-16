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
    
    var presenter: LoginPresenterProtocol?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func showSignUp() {
        presenter?.showSignUp()
    }
}

// MARK: - Configure UI

extension LoginViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureLoginView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Login"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let color = UIColor(patternImage: UIImage(named: "hologram_1")!)
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: color]
                
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
//            title: "Sign Up",
//            style: .plain,
//            target: self,
//            action: #selector(showSignUp)
//        )
    }
        
    private func configureLoginView() {
        let loginView = AuthView(
            option: .login,
            buttonTappedWithOption: { option in
                self.presenter?.changeFlow(flow: .onboarding)
            }, changeOptionTapped: {
                
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
    func setLoginView() {
        presenter?.setLoginView()
    }
}
