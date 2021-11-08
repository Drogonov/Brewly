//
//  BrewItemPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 08.11.2021.
//

import UIKit

protocol BrewItemPresenterProtocol: AnyObject {
    init(view: BrewItemViewProtocol,
         router: MainTabBarRouterProtocol)
    func setBrewItemView()
}

class BrewItemPresenter: BrewItemPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: BrewItemViewProtocol?
    var router: MainTabBarRouterProtocol
        
    // MARK: - Init

    required init(view: BrewItemViewProtocol,
                  router: MainTabBarRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Protocol Functions

    func setBrewItemView() {
        self.view?.setBrewItemView()
    }
}
