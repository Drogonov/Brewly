//
//  SignUpViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit
import SwiftUI

protocol SignUpViewProtocol: AnyObject {
    func setSignUpView()
}

class SignUpViewController: UIViewController {
    
    // MARK: - Properties

    var presenter: SignUpPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureSignUpView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Sign Up"
    }
    
    private func configureSignUpView() {
        let signUpView = AuthView(
            option: .signUp,
            buttonTappedWithOption: { option in
                debugPrint(option)
            }, changeOptionTapped: {
                
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
    func setSignUpView() {
        presenter.setSignUpView()
    }
}
