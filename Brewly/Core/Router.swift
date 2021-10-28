//
//  Router.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit

enum LoadingCase {
    case auth
    case onboarding
}

protocol Router {
    var navigationController: UINavigationController? { get set }
}

protocol MainRouterProtocol: Router {
    var navigationController: UINavigationController? { get set }
    var loadingCase: LoadingCase { get set }
    
    func initialViewController()
    
    init(navigationController: UINavigationController,
         loadingCase: LoadingCase)
}

class MainRouter: MainRouterProtocol {
    
    // MARK: - Properties

    var navigationController: UINavigationController?
    var loadingCase: LoadingCase

    // MARK: - Init

    required init(navigationController: UINavigationController,
                  loadingCase: LoadingCase) {
        self.navigationController = navigationController
        self.loadingCase = loadingCase
    }
    
    // MARK: - Protocol Functions

    func initialViewController() {
        switch loadingCase {
        case .auth:
            showAuthFlow()
        case .onboarding:
            showOnboardingFlow()
        }
    }
    
    // MARK: - Helper Functions

    private func showAuthFlow() {
        if let navigationController = navigationController {
            let builder = AuthModuleBuilder()
            let router = AuthRouter(navigationController: navigationController,
                                    builder: builder)
            router.showLogin()
        }
    }
    
    private func showOnboardingFlow() {
        if let navigationController = navigationController {
            let builder = OnboardingModuleBuilder()
            let router = OnboardingRouter(navigationController: navigationController,
                                    builder: builder)
            router.showOnboarding()
        }
    }
}
