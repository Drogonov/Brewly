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
        view.backgroundColor = .red
    }
}

// MARK: - SignUpViewProtocol

extension SignUpViewController: SignUpViewProtocol {
    func setSignUpView() {
        presenter.setSignUpView()
    }
}
