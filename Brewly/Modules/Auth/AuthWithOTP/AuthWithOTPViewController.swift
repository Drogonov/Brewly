//
//  AuthWithOTPViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 24.11.2021.
//

import UIKit
import SwiftUI

protocol AuthWithOTPViewProtocol: BaseViewLoader {
    func setAuthWithOTPView(with model: AuthWithOTPViewModel)
}

class AuthWithOTPViewController: BaseViewController {
    
    // MARK: - Properties

    var presenter: AuthWithOTPPresenterProtocol?
    
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

extension AuthWithOTPViewController {
    private func configureUI() {
        view.backgroundColor = UIColor.systemGroupedBackground
        presenter?.setAuthWithOTPView()
    }
            
    private func configureView(with model: AuthWithOTPViewModel) {
        let view = AuthWithOTPView(
            model: model,
            authButtonTapped: { phone, password in
                self.presenter?.authWithData(phone: phone, password: password)
            }
        )
        addMainViewToViewController(view)
    }
}

// MARK: - SignUpViewProtocol

extension AuthWithOTPViewController: AuthWithOTPViewProtocol {
    func setAuthWithOTPView(with model: AuthWithOTPViewModel) {
        configureView(with: model)
        setNavigationBarTitle(with: model.navigationTitle)
    }
}
