//
//  DB.swift
//  Brewly
//
//  Created by Anton Vlezko on 09.11.2021.
//

import Foundation
import Firebase

struct DB {
    static let REF = Database.database().reference()
    static let REF_USERS = REF.child("users")
    static let REF_MESSAGES = REF.child("messages")
}
