//
//  AuthService.swift
//  Brewly
//
//  Created by Anton Vlezko on 09.11.2021.
//

import Firebase

protocol AuthServiceProtocol: AnyObject {
    func handleLogin(email: String, password: String, completion: @escaping(Bool) -> Void)
    func handleSignUp(fullname: String, email: String, password: String, completion: @escaping(Bool) -> Void)
}

class AuthService {
    
    // MARK: - Properties
    
    private let dataUploader: DataUploaderProtocol
    
    // MARK: - Init
    
    init(dataUploader: DataUploaderProtocol) {
        self.dataUploader = dataUploader
    }
}

// MARK: - AuthServiceProtocol
extension AuthService: AuthServiceProtocol {
    func handleLogin(email: String, password: String, completion: @escaping(Bool) -> Void) {
        var wasAuthSuccessful = true
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                wasAuthSuccessful = false
                completion(wasAuthSuccessful)
                print("DEBUG: Failed to log user in with error \(error.localizedDescription)")
                return
            }
            completion(wasAuthSuccessful)
        }
    }
    
    func handleSignUp(fullname: String, email: String, password: String, completion: @escaping(Bool) -> Void) {
        var wasSignUpSuccessful = true
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                wasSignUpSuccessful = false
                completion(wasSignUpSuccessful)
                print("DEBUG: Failed to register user with error \(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            let values = [
                "email": email,
                "fullname" : fullname
            ] as [String : Any]
            
            self.dataUploader.updateUserValues(uid: uid, values: values) { (err, ref) in
                if let error = error {
                    wasSignUpSuccessful = false
                    completion(wasSignUpSuccessful)
                    print("DEBUG: Failed to register user with error \(error.localizedDescription)")
                    return
                }
            }
            completion(wasSignUpSuccessful)
        }
    }
}
