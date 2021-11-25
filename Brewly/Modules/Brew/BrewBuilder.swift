//
//  BrewBuilder.swift
//  Brewly
//
//  Created by Anton Vlezko on 25.11.2021.
//

import UIKit

protocol BrewBuilderProtocol {
    func createBrewModule(router: MainTabBarRouterProtocol) -> UIViewController
    func createBrewConfigurationModule(router: MainTabBarRouterProtocol) -> UIViewController
    func createBrewListModule(router: MainTabBarRouterProtocol, model: BrewConfigurationModel) -> UIViewController
    func createBrewItemModule(router: MainTabBarRouterProtocol) -> UIViewController
}

class BrewBuilder: BrewBuilderProtocol {
    func createBrewModule(router: MainTabBarRouterProtocol) -> UIViewController {
        let model = BrewViewModel(
            navigationTitle: "Brew",
            brewButtonText: "Let's Brew!"
        )
        let view = BrewViewController()
        let presenter = BrewPresenter(
            view: view,
            router: router,
            model: model
        )
        view.presenter = presenter
        return view
    }
    
    func createBrewConfigurationModule(router: MainTabBarRouterProtocol) -> UIViewController {
        let view = BrewConfigurationViewController()
        let presenter = BrewConfigurationPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createBrewListModule(router: MainTabBarRouterProtocol, model: BrewConfigurationModel) -> UIViewController {
        let view = BrewListViewController()
        let presenter = BrewListPresenter(
            view: view,
            router: router,
            model: model
        )
        view.presenter = presenter
        return view
    }
    
    func createBrewItemModule(router: MainTabBarRouterProtocol) -> UIViewController {
        let view = BrewItemViewController()
        let presenter = BrewItemPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
