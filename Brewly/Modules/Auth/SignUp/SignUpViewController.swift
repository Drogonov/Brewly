//
//  SignUpViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit

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
        configureNavigationController()
    }
    
    private func configureNavigationController() {
        self.navigationItem.title = "Sign Up"
    }
}

// MARK: - SignUpViewProtocol

extension SignUpViewController: SignUpViewProtocol {
    func setSignUpView() {
        presenter.setSignUpView()
    }
}
