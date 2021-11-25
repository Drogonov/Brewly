////
////  SignUpViewController.swift
////  Brewly
////
////  Created by Anton Vlezko on 28.10.2021.
////
//
//import UIKit
//import SwiftUI
//
//protocol SignUpViewProtocol: AnyObject {
//    func setSignUpView(with model: AuthViewModel)
//}
//
//class SignUpViewController: BaseViewController {
//    
//    // MARK: - Properties
//
//    var presenter: SignUpPresenterProtocol?
//    
//    // MARK: - Lifecycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureUI()
//    }
//    
//    // MARK: - Selectors
//    
//    @objc override func handleSwipeRightGesture(gesture: UISwipeGestureRecognizer) -> Void {
//        if gesture.direction == .right {
//            self.presenter?.showLogin()
//        }
//    }
//}
//
//// MARK: - Configure UI
//
//extension SignUpViewController {
//    private func configureUI() {
//        presenter?.setSignUpView()
//    }
//
//    private func configureView(with model: AuthViewModel) {
//        let view = AuthView(
//            model: model,
//            buttonTappedWithConfig: { config in
//                self.presenter?.authButtonTappedWith(option: model.option, config: config, viewController: self)
//            }, changeOptionTapped: {
//                self.presenter?.showLogin()
//            })
//        addMainViewToViewController(view)
//    }
//}
//
//// MARK: - SignUpViewProtocol
//
//extension SignUpViewController: SignUpViewProtocol {
//    func setSignUpView(with model: AuthViewModel) {
//        setNavigationBarTitle(with: "Sign Up")
//        configureView(with: model)
//    }
//}
