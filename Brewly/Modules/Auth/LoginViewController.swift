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
    
    // MARK: - Selectors
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .left {
            self.presenter?.showSignUp()
        }
    }
}

// MARK: - Configure UI

extension LoginViewController {
    private func configureUI() {
        view.backgroundColor = UIColor.backgroundColor
        configureNavigationBar()
        configureSwipeGesture()
        presenter?.setLoginView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Login"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.primaryTextColor
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.accentColor]
    }
        
    private func configureView(with _model: AuthViewModel) {
        let view = AuthView(
            model: _model,
            buttonTappedWithConfig: { config in
                self.presenter?.authButtonTappedWith(option: _model.option, config: config)
            }, changeOptionTapped: {
                self.presenter?.showSignUp()
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
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
}

// MARK: - LoginViewProtocol

extension LoginViewController: LoginViewProtocol {
    func setLoginView(with _model: AuthViewModel) {
        configureView(with: _model)
    }
}
