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
    
    // MARK: - Selectors
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            self.presenter?.showLogin()
        }
    }
}

// MARK: - Configure UI

extension SignUpViewController {
    private func configureUI() {
        view.backgroundColor = UIColor.backgroundColor
        configureNavigationBar()
        presenter?.setSignUpView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Sign Up"
    }
    
    private func configureView(with _model: AuthViewModel) {
        let view = AuthView(
            model: _model,
            buttonTappedWithConfig: { config in
                self.presenter?.authButtonTappedWith(option: _model.option, config: config)
            }, changeOptionTapped: {
                self.presenter?.showLogin()
            })
        addToViewController(view)
    }
    
    private func addToViewController(_ newView: AuthView) {
        let viewCtrl = UIHostingController(rootView: newView)
        addChild(viewCtrl)
        view.addSubview(viewCtrl.view)
        
        viewCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
    }
    
    private func configureSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
}

// MARK: - SignUpViewProtocol

extension SignUpViewController: SignUpViewProtocol {
    func setSignUpView(with _model: AuthViewModel) {
        configureView(with: _model)
    }
}
