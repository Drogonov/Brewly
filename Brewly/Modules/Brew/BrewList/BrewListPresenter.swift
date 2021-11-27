//
//  BrewListPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 27.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

protocol BrewListPresenterProtocol: AnyObject {
    init(
        view: BrewListViewControllerProtocol,
        router: MainTabBarRouterProtocol,
        model: BrewConfigurationModel
    )
    func setView()
    func brewCellTapped(with viewController: UIViewController)
}

class BrewListPresenter {
    
    // MARK: - Properties
    
    weak var view: BrewListViewControllerProtocol?
    var router: MainTabBarRouterProtocol
    var model: BrewConfigurationModel
    
    // MARK: - Construction
    
    required init(
        view: BrewListViewControllerProtocol,
        router: MainTabBarRouterProtocol,
        model: BrewConfigurationModel
    ) {
        self.view = view
        self.router = router
        self.model = model
    }
}

// MARK: - BrewListPresenterProtocol

extension BrewListPresenter: BrewListPresenterProtocol {
    func setView() {
        let viewModel = configureViewModel()
        self.view?.setView(with: viewModel)
    }
    
    func brewCellTapped(with viewController: UIViewController) {
        router.showBrewItem(with: viewController)
    }
}

extension BrewListPresenter {
    func configureViewModel() -> BrewListViewModel {
        return BrewListViewModel(
            navigationTitle: "Brew List"
        )
    }
}
