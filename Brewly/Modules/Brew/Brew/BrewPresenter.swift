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
        router: MainTabBarRouterProtocol
    )
    func setBrewView()
    func showBrewConfigurationView(with vc: UIViewController)
    
}

class BrewPresenter {
    
    // MARK: - Services

    // MARK: - Properties
    
    weak var view: BrewViewProtocol?
    var router: MainTabBarRouterProtocol
    
    // MARK: - Construction
    
    required init(
        view: BrewViewProtocol,
        router: MainTabBarRouterProtocol
    ) {
        self.view = view
        self.router = router
    }
}

// MARK: - BrewPresenterProtocol

extension BrewPresenter: BrewPresenterProtocol {
    func setBrewView() {
        let viewModel = configureViewModel()
        self.view?.setBrewView(with: viewModel)
    }
    
    func showBrewConfigurationView(with vc: UIViewController) {
        self.router.showBrewConfiguration(with: vc)
    }
}

// MARK: - Helper Functions

extension BrewPresenter {
    func configureViewModel() -> BrewViewModel {
        return BrewViewModel(
            navigationTitle: "Brew",
            brewButtonText: "Let's Brew!"
        )
    }
}
