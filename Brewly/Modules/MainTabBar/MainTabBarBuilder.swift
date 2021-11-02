//
//  MainTabBarBuilder.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import UIKit

protocol MainTabBarBuilderProtocol {
    func createHistoryModule(router: MainTabBarRouterProtocol) -> UIViewController
    func createBrewModule(router: MainTabBarRouterProtocol) -> UIViewController
    func createProfileModule(router: MainTabBarRouterProtocol) -> UIViewController
    
    func createDetailHistoryModule(router: MainTabBarRouterProtocol) -> UIViewController
    
}

class MainTabBarBuilder: MainTabBarBuilderProtocol {
    func createHistoryModule(router: MainTabBarRouterProtocol) -> UIViewController {
        let view = HistoryViewController()
        let presenter = HistoryPresenter(view: view,
                                         router: router)
        view.presenter = presenter
        return view
    }
    
    func createBrewModule(router: MainTabBarRouterProtocol) -> UIViewController {
        let view = BrewViewController()
        let presenter = BrewPresenter(view: view,
                                      router: router)
        view.presenter = presenter
        return view
    }
    
    func createProfileModule(router: MainTabBarRouterProtocol) -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view,
                                         router: router)
        view.presenter = presenter
        return view
    }
    
    
    func createDetailHistoryModule(router: MainTabBarRouterProtocol) -> UIViewController {
        let view = DetailHistoryViewController()
        let presenter = DetailHistoryPresenter(view: view,
                                               router: router)
        view.presenter = presenter
        return view
    }
}

