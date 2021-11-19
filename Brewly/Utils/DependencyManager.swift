//
//  DependencyManager.swift
//  Brewly
//
//  Created by Anton Vlezko on 19.11.2021.
//

import Foundation

protocol Injectable {}

@propertyWrapper
struct Inject<T: Injectable> {
    let wrappedValue: T
    
    init() {
        wrappedValue = Resolver.shared.resolve()
    }
}

class Resolver {
    
    private var storage = [String: Injectable]()
    
    static let shared = Resolver()
    private init() {
        debugPrint("Resolver inited")
    }
    
    func add<T: Injectable>(_ injectable: T) {
        let key = String(reflecting: injectable)
        storage[key] = injectable
    }

    func resolve<T: Injectable>() -> T {
        let key = String(reflecting: T.self)
        
        guard let injectable = storage[key] as? T else {
            fatalError("\(key) has not been added as an injectable object.")
        }
        
        return injectable
    }

}

class DependencyManager {
    private let authService: AuthService
    private let firebaseService: FirebaseService
    private let userSettingsService: UserSettingsService
    
    init() {
        self.authService = AuthService()
        self.firebaseService = FirebaseService()
        self.userSettingsService = UserSettingsService()
        addDependencies()
    }
    
    private func addDependencies() {
        let resolver = Resolver.shared
        resolver.add(authService)
        resolver.add(firebaseService)
        resolver.add(userSettingsService)
    }
}
