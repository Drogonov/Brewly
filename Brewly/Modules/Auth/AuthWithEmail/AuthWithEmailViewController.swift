//
//  AuthWithEmailViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 17.11.2021.
//

import UIKit
import SwiftUI

protocol AuthWithEmailViewProtocol: BaseViewLoader {
    func setAuthWithEmailView(with _model: AuthWithEmailViewModel)
}

class AuthWithEmailViewController: BaseViewController {
    
    // MARK: - Properties

    var presenter: AuthWithEmailPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc override func handleSwipeRightGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Configure UI

extension AuthWithEmailViewController {
    private func configureUI() {
        view.backgroundColor = UIColor.systemGroupedBackground
        presenter?.setAuthWithEmailView()
    }
            
    private func configureView(with _model: AuthWithEmailViewModel) {
        let view = AuthWithEmailView(
            model: _model,
            authButtonTapped: { fullname, email, password in
                self.presenter?.authWithData(fullname: fullname, email: email, password: password)
            }
        )
        addMainViewToViewController(view)
    }
}

// MARK: - SignUpViewProtocol

extension AuthWithEmailViewController: AuthWithEmailViewProtocol {
    func setAuthWithEmailView(with _model: AuthWithEmailViewModel) {
        configureView(with: _model)
        setNavigationBarTitle(with: _model.navigationTitle)
    }
}
