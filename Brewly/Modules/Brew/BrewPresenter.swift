//
//  BrewPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import Foundation

protocol BrewPresenterProtocol: AnyObject {
    init(view: BrewViewProtocol,
         router: MainTabBarRouterProtocol)
    func setBrewView()
}

class BrewPresenter: BrewPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: BrewViewProtocol?
    var router: MainTabBarRouterProtocol
        
    // MARK: - Init

    required init(view: BrewViewProtocol,
                  router: MainTabBarRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Protocol Functions

    func setBrewView() {
        self.view?.setBrewView()
    }
}
