//
//  BrewListPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import UIKit

protocol BrewListPresenterProtocol: AnyObject {
    init(view: BrewListViewProtocol,
         router: MainTabBarRouterProtocol,
         model: BrewConfigurationModel)
    func setBrewListView()
    func showBrewItemView(with _vc: UIViewController)
}

class BrewListPresenter: BrewListPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: BrewListViewProtocol?
    var router: MainTabBarRouterProtocol
    var model: BrewConfigurationModel
        
    // MARK: - Init

    required init(
        view: BrewListViewProtocol,
        router: MainTabBarRouterProtocol,
        model: BrewConfigurationModel
    ) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    // MARK: - Protocol Functions

    func setBrewListView() {
        self.view?.setBrewListView()
    }
    
    func showBrewItemView(with _vc: UIViewController) {
        router.showBrewItem(with: _vc)
    }
}
