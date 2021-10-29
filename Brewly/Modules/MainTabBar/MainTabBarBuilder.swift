//
//  MainTabBarBuilder.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import UIKit

protocol MainTabBarBuilderProtocol {
    func createHistoryModule(router: MainTabBarRouterProtocol) -> UIViewController
    func createDetailHistoryModule(router: MainTabBarRouterProtocol) -> UIViewController
    func createSettingsModule(router: MainTabBarRouterProtocol) -> UIViewController
}

class MainTabBarBuilder: MainTabBarBuilderProtocol {
    func createHistoryModule(router: MainTabBarRouterProtocol) -> UIViewController {
        let view = HistoryViewController()
        let presenter = HistoryPresenter(view: view,
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
    
    func createSettingsModule(router: MainTabBarRouterProtocol) -> UIViewController {
        let view = SettingsViewController()
        let presenter = SettingsPresenter(view: view,
                                          router: router)
        view.presenter = presenter
        return view
    }
    
}

