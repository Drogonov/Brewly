//
//  HistoryBuilder.swift
//  Brewly
//
//  Created by Anton Vlezko on 25.11.2021.
//

import UIKit

protocol HistoryBuilderProtocol {
    func createHistoryModule(router: MainTabBarRouterProtocol) -> UIViewController
    func createDetailHistoryModule(router: MainTabBarRouterProtocol) -> UIViewController
}

class HistoryBuilder: HistoryBuilderProtocol {
    func createHistoryModule(router: MainTabBarRouterProtocol) -> UIViewController {
        let view = HistoryViewController()
        let presenter = HistoryPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailHistoryModule(router: MainTabBarRouterProtocol) -> UIViewController {
        let view = DetailHistoryViewController()
        let presenter = DetailHistoryPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
