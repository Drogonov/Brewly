//
//  FirebaseService.swift
//  Brewly
//
//  Created by Anton Vlezko on 09.11.2021.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

protocol FirebaseServiceProtocol: AnyObject {
    func checkIfUserIsLoggedIn(completion: @escaping(Bool) -> Void)
    func signOut(completion: @escaping(Bool) -> Void)
    func fetchUserData(completion: @escaping(User) -> Void)
    
    func updateProfileImage(user: User, profileImg: UIImage, completion: @escaping (Bool, String?) -> Void)
    func updateUserFullname(user: User, updatedUsername: String?, completion: @escaping (Bool) -> Void)
    
    func connectionCheck(completion: @escaping(Bool) -> Void)
}

class FirebaseService: Injectable {
    
    // MARK: - Properties
    
    let dataUploader: DataUploaderProtocol
    let dataFetcher: DataFetcherProtocol
    
    // MARK: - Construction
    
    required init() {
        self.dataUploader = DataUploader()
        self.dataFetcher = DataFetcher()
    }
    
    init(
        dataUploader: DataUploaderProtocol,
        dataFetcher: DataFetcherProtocol
    ) {
        self.dataUploader = dataUploader
        self.dataFetcher = dataFetcher
    }
}

// MARK: - FirebaseServiceProtocol

extension FirebaseService: FirebaseServiceProtocol {
    
    // MARK: - Read UserData Protocol Methods
    
    func checkIfUserIsLoggedIn(completion: @escaping (Bool) -> Void) {
        var wasCheckSuccessful = true
        if Auth.auth().currentUser?.uid == nil {
            wasCheckSuccessful = false
            completion(wasCheckSuccessful)
        } else {
            completion(wasCheckSuccessful)
        }
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        var wasSignOutSuccessful = true
        do {
            try Auth.auth().signOut()
            completion(wasSignOutSuccessful)
        } catch {
            wasSignOutSuccessful = false
            print("DEBUG: Error signing out")
            completion(wasSignOutSuccessful)
        }
    }
    
    func fetchUserData(completion: @escaping (User) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        self.dataFetcher.fetchUserData(uid: currentUid) { user in
            completion(user)
        }
    }
    
    func connectionCheck(completion: @escaping(Bool) -> Void) {
        let connectedRef = Database.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { (snapshot) in
            print(snapshot)
            if snapshot.value as? Bool ?? false {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    // MARK: - Update UserData Protocol Methods
    
    func updateProfileImage(user: User, profileImg: UIImage, completion: @escaping (Bool, String?) -> Void) {
        guard let uploadData = profileImg.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        
        if user.profileImageUrl == nil {
            uploadProfileImage(uid: user.uid, uploadData: uploadData, filename: filename, completion: completion)
        } else {
            deleteImageFromStorage(storagePath: user.profileImageUrl!) { _ in
                self.uploadProfileImage(uid: user.uid, uploadData: uploadData, filename: filename, completion: completion)
            }
        }
    }
    
    func updateUserFullname(user: User, updatedUsername: String?, completion: @escaping (Bool) -> Void) {
        var wasUpdateSuccessful = true
        guard let fullname = updatedUsername else { return }
        
        let values = ["fullname": fullname] as [String : Any]
        self.dataUploader.updateUserValues(uid: user.uid, values: values) { (error, ref) in
            if let error = error {
                wasUpdateSuccessful = false
                print("DEBUG: Failed to update user fullname with error \(error.localizedDescription)")
                completion(wasUpdateSuccessful)
            }
            completion(wasUpdateSuccessful)
        }
    }
}
// MARK: - Helper Functions

extension FirebaseService {
    
    private func uploadProfileImage(uid: String, uploadData: Data, filename: String, completion: @escaping(Bool, String?) -> Void) {
        var wasImageUploaded = true
        let storageRef = Storage.storage().reference().child("profile_images").child(filename)
        storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
            if let error = error {
                wasImageUploaded = false
                print("DEBUG: Failed to upload image to Firebase Storage with error", error.localizedDescription)
                completion(wasImageUploaded, nil)
            }
            
            storageRef.downloadURL(completion: { (downloadURL, error) in
                guard let profileImageUrl = downloadURL?.absoluteString else {
                    wasImageUploaded = false
                    print("DEBUG: Profile image url is nil")
                    completion(wasImageUploaded, nil)
                    return
                }
                self.updateUserProfileWithImageUrl(uid: uid, profileImageUrl: profileImageUrl, completion: completion)
            })
        })
    }
    
    private func updateUserProfileWithImageUrl(uid: String, profileImageUrl: String, completion: @escaping(Bool, String?) -> Void) {
        var wasImageUploaded = true
        self.dataUploader.updateUserValues(uid: uid, values: ["profileImageUrl": profileImageUrl]) { (error, ref) in
            if let error = error {
                wasImageUploaded = false
                print("DEBUG: Failed to update user profile URL in Firebase", error.localizedDescription)
                self.deleteImageFromStorage(storagePath: profileImageUrl) { _ in
                    completion(wasImageUploaded, nil)
                }
            }
            completion(wasImageUploaded, profileImageUrl)
        }
    }
    
    private func deleteImageFromStorage(storagePath: String, completion: @escaping(Bool) -> Void) {
        var wasImageDeleted = true
        let desertRef = Storage.storage().reference(forURL: storagePath)
        desertRef.delete { error in
            if let error = error {
                wasImageDeleted = false
                print("DEBUG: Failed to delete image", error.localizedDescription)
                completion(wasImageDeleted)
            }
            completion(wasImageDeleted)
        }
    }
}
