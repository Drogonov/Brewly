//
//  AuthService.swift
//  Brewly
//
//  Created by Anton Vlezko on 09.11.2021.
//

import Firebase
import UIKit
import GoogleSignIn

protocol AuthServiceProtocol: AnyObject {
    func handleLogin(email: String, password: String, completion: @escaping(Bool) -> Void)
    func handleSignUp(fullname: String, email: String, password: String, completion: @escaping(Bool) -> Void)
    func handleGoogleSignUp(viewController: UIViewController, completion: @escaping(Bool) -> Void)
}

class AuthService: Injectable {
    
    // MARK: - Properties
    
    private let dataUploader: DataUploaderProtocol
    
    // MARK: - Construction
    
    required init() { self.dataUploader = DataUploader() }
    
    init(dataUploader: DataUploaderProtocol) {
        self.dataUploader = dataUploader
    }
}

// MARK: - AuthServiceProtocol
extension AuthService: AuthServiceProtocol {
    func handleLogin(email: String, password: String, completion: @escaping(Bool) -> Void) {
        var wasAuthSuccessful = false
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(wasAuthSuccessful)
                print("DEBUG: Failed to log user in with error \(error.localizedDescription)")
                return
            }
            wasAuthSuccessful = true
            completion(wasAuthSuccessful)
        }
    }
    
    func handleSignUp(fullname: String, email: String, password: String, completion: @escaping(Bool) -> Void) {
        var wasAuthSuccessful = false
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(wasAuthSuccessful)
                print("DEBUG: Failed to register user with error \(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else {
                debugPrint("DEBUG: Failed to register user result?.user.uid == nil")
                completion(wasAuthSuccessful)
                return
            }
            
            let values = [
                "email": email,
                "fullname" : fullname
            ] as [String : Any]
            
            self.dataUploader.updateUserValues(uid: uid, values: values) { (err, ref) in
                if let error = error {
                    completion(wasAuthSuccessful)
                    print("DEBUG: Failed to register user with error \(error.localizedDescription)")
                    return
                }
            }
            wasAuthSuccessful = true
            completion(wasAuthSuccessful)
        }
    }
    
    func handleGoogleSignUp(viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        var wasAuthSuccessful = false

        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: viewController) { [unowned self] user, error in
            
            if let error = error {
                completion(wasAuthSuccessful)
                print("DEBUG: Failed to sign in and retrieve data with error:", error)
                return
            }
            
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken
            else {
                print("DEBUG: Failed to sign in authentication or idToken == nil")
                completion(wasAuthSuccessful)
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: authentication.accessToken
            )
            
            Auth.auth().signIn(with: credential) { (result, error) in
                if let error = error {
                    print("DEBUG: Failed to sign in and retrieve data with error:", error)
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
                
                
                self.dataUploader.updateUserValues(uid: uid, values: values) { (err, ref) in
                    if let error = error {
                        completion(wasAuthSuccessful)
                        print("DEBUG: Failed to upload data to server GIDSignIn with error:", error)
                        return
                    }
                    wasAuthSuccessful = true
                    completion(wasAuthSuccessful)
                }
            }
        }
    }
}
