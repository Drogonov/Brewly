//
//  SettingsPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol,
         router: MainTabBarRouterProtocol)
    func setSettingsView()
}

class SettingsPresenter: SettingsPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: SettingsViewProtocol?
    var router: MainTabBarRouterProtocol
        
    // MARK: - Init

    required init(view: SettingsViewProtocol,
                  router: MainTabBarRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Protocol Functions

    func setSettingsView() {
        self.view?.setSettingsView()
    }
}
