//
//  DataUploader.swift
//  Brewly
//
//  Created by Anton Vlezko on 09.11.2021.
//

import Firebase

protocol DataUploaderProtocol {
    func updateUserValues(uid: String, values: [String: Any], completion: @escaping(Error?, DatabaseReference) -> Void)    
}

class DataUploader: DataUploaderProtocol {
    func updateUserValues(uid: String, values: [String : Any], completion: @escaping (Error?, DatabaseReference) -> Void) {
        DB.REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
}
