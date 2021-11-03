//
//  BrewConfigurationPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import UIKit

protocol BrewConfigurationPresenterProtocol: AnyObject {
    init(view: BrewConfigurationViewProtocol,
         router: MainTabBarRouterProtocol)
    func setBrewConfigurationView()
    func showBrewListView(with _vc: UIViewController)
}

class BrewConfigurationPresenter: BrewConfigurationPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: BrewConfigurationViewProtocol?
    var router: MainTabBarRouterProtocol
        
    // MARK: - Init

    required init(view: BrewConfigurationViewProtocol,
                  router: MainTabBarRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Protocol Functions

    func setBrewConfigurationView() {
        self.view?.setBrewConfigurationView()
    }
    
    func showBrewListView(with _vc: UIViewController) {
        self.router.showBrewList(with: _vc)
    }
}
