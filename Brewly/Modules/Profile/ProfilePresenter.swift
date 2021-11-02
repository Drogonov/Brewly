//
//  ProfilePresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol,
         router: MainTabBarRouterProtocol)
    func setProfileView()
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: ProfileViewProtocol?
    var router: MainTabBarRouterProtocol
        
    // MARK: - Init

    required init(view: ProfileViewProtocol,
                  router: MainTabBarRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Protocol Functions

    func setProfileView() {
        self.view?.setProfileView()
    }
}
