//
//  BrewConfigurationPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import UIKit

protocol BrewConfigurationPresenterProtocol: AnyObject {
    init(
        view: BrewConfigurationViewProtocol,
        router: MainTabBarRouterProtocol
    )
    func setBrewConfigurationView()
    func showBrewListView(
        with tuple: (
            cappingName: String, amountOfSamples: Int, comment: String
        ),
        and vc: UIViewController
    )
}

class BrewConfigurationPresenter {
    
    // MARK: - Services
    
    // MARK: - Properties
    
    weak var view: BrewConfigurationViewProtocol?
    var router: MainTabBarRouterProtocol
    
    // MARK: - Init
    
    required init(
        view: BrewConfigurationViewProtocol,
        router: MainTabBarRouterProtocol
    ) {
        self.view = view
        self.router = router
    }
}

// MARK: - BrewConfigurationPresenterProtocol

extension BrewConfigurationPresenter: BrewConfigurationPresenterProtocol {
    func setBrewConfigurationView() {
        let viewModel = configureViewModel()
        self.view?.setBrewConfigurationView(with: viewModel)
    }
    
    func showBrewListView(with tuple: (cappingName: String, amountOfSamples: Int, comment: String), and vc: UIViewController) {
        let model = BrewConfigurationModel(
            cappingName: tuple.cappingName,
            amountOfSamples: tuple.amountOfSamples,
            comment: tuple.comment
        )
        self.router.showBrewList(with: model, and: vc)
    }
}

// MARK: - Helper Functions

extension BrewConfigurationPresenter {
    func configureViewModel() -> BrewConfigurationViewModel {
        return BrewConfigurationViewModel(
            navigationTitle: "Brew Configuration",
            brewConfigurationButtonText: "Let's Brew!"
        )
    }
}
