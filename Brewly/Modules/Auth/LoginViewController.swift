//
//  LoginViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit
import SwiftUI
import GoogleSignIn

protocol LoginViewProtocol: AnyObject {
    func setLoginView(with _model: AuthViewModel)
}

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: LoginPresenterProtocol?
    
    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc override func handleSwipeLeftGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .left {
            self.presenter?.showSignUp()
        }
    }
}

// MARK: - Configure UI

extension LoginViewController {
    private func configureUI() {
        setNavigationBarTitle(with: "Login")
        presenter?.setLoginView()
    }
            
    private func configureView(with _model: AuthViewModel) {
        let view = AuthView(
            model: _model,
            buttonTappedWithConfig: { config in
                self.presenter?.authButtonTappedWith(option: _model.option, config: config)
            }, changeOptionTapped: {
                self.presenter?.showSignUp()
            })
        addMainViewToViewController(view)
    }
}

// MARK: - LoginViewProtocol

extension LoginViewController: LoginViewProtocol {
    func setLoginView(with _model: AuthViewModel) {
        configureView(with: _model)
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Failed to sign in with error:", error)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                print("Failed to sign in and retrieve data with error:", error)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            guard let email = result?.user.email else { return }
            guard let username = result?.user.displayName else { return }
            guard let photoURL = result?.user.photoURL else { return }
            
            let photoURLString = photoURL.absoluteString
            
            let values = ["email": email,
                          "fullname": username,
                          "profileImageUrl": photoURLString] as [String : Any]
            
            Service.shared.updateUserValues(uid: uid, values: values) { (err, ref) in
                if let error = error {
                    print("Failed to upload data to server GIDSignIn with error:", error)
                    return
                }
                self.delegate?.userLoginVC(self)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

