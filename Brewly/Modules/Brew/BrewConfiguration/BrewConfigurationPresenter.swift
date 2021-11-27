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
        router: MainTabBarRouterProtocol,
        viewModel: BrewConfigurationViewModel
    )
    func setBrewConfigurationView()
    func showBrewListView(
        with tuple: (
            cappingName: String, amountOfSamples: Int, comment: String
        ),
        and vc: UIViewController
    )
}

class BrewConfigurationPresenter: BrewConfigurationPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: BrewConfigurationViewProtocol?
    var router: MainTabBarRouterProtocol
    var viewModel: BrewConfigurationViewModel
    
    // MARK: - Init
    
    required init(
        view: BrewConfigurationViewProtocol,
        router: MainTabBarRouterProtocol,
        viewModel: BrewConfigurationViewModel
    ) {
        self.view = view
        self.router = router
        self.viewModel = viewModel
    }
    
    // MARK: - Protocol Functions
    
    func setBrewConfigurationView() {
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
