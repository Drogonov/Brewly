//
//  DataFetcher.swift
//  Brewly
//
//  Created by Anton Vlezko on 09.11.2021.
//

import Firebase

protocol DataFetcherProtocol {
    func fetchUserData(uid: String, completion: @escaping(User) -> Void)
}

class DataFetcher: DataFetcherProtocol {
    func fetchUserData(uid: String, completion: @escaping (User) -> Void) {
        DB.REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            DispatchQueue.main.async {
                completion(user)
            }
        }
    }
}
