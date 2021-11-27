//
//  BrewPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import UIKit

protocol BrewPresenterProtocol: AnyObject {
    init(
        view: BrewViewProtocol,
        router: MainTabBarRouterProtocol,
        viewModel: BrewViewModel
    )
    func setBrewView()
    func showBrewConfigurationView(with vc: UIViewController)
    
}

class BrewPresenter: BrewPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: BrewViewProtocol?
    var router: MainTabBarRouterProtocol
    var viewModel: BrewViewModel
    
    // MARK: - Init
    
    required init(
        view: BrewViewProtocol,
        router: MainTabBarRouterProtocol,
        viewModel: BrewViewModel
    ) {
        self.view = view
        self.router = router
        self.viewModel = viewModel
    }
    
    // MARK: - Protocol Functions
    
    func setBrewView() {
        self.view?.setBrewView(with: viewModel)
    }
    
    func showBrewConfigurationView(with vc: UIViewController) {
        self.router.showBrewConfiguration(with: vc)
    }
}
