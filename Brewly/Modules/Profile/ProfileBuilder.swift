//
//  ProfileBuilder.swift
//  Brewly
//
//  Created by Anton Vlezko on 25.11.2021.
//

import UIKit

protocol ProfileBuilderProtocol {
    func createProfileModule(router: MainTabBarRouterProtocol) -> UIViewController
}

class ProfileBuilder: ProfileBuilderProtocol{
    func createProfileModule(router: MainTabBarRouterProtocol) -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}


