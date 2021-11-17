//
//  AuthWithEmailViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 17.11.2021.
//

import UIKit
import SwiftUI

protocol AuthWithEmailViewProtocol: AnyObject {
    func setAuthWithEmailView(with _model: AuthWithEmailViewModel)
}

class AuthWithEmailViewController: UIViewController {
    
    // MARK: - Properties

    var presenter: AuthWithEmailPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Configure UI

extension AuthWithEmailViewController {
    private func configureUI() {
        view.backgroundColor = UIColor.systemGroupedBackground
        configureKeyboard()
        presenter?.setAuthWithEmailView()
    }
    
    private func configureNavigationBar(with _title: String) {
        self.navigationItem.title = _title
    }
    
    private func configureKeyboard() {
        self.hideKeyboardWhenTappedAround()
    }
    
    private func configureView(with _model: AuthWithEmailViewModel) {
        let view = AuthWithEmailView(
            model: _model,
            authButtonTapped: { userName, email, password in }
        )
        addToViewController(view)
    }
    
    private func addToViewController(_ newView: AuthWithEmailView) {
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

extension AuthWithEmailViewController: AuthWithEmailViewProtocol {
    func setAuthWithEmailView(with _model: AuthWithEmailViewModel) {
        configureView(with: _model)
        configureNavigationBar(with: _model.navigationTitle)
    }
}
