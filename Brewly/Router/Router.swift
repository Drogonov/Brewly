//
//  Router.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit

class MainRouter {
    
    // MARK: - Properties
    
    var window: UIWindow?
    var navigationController: UINavigationController
    var flowCase: FlowCase
    var authBuilder: AuthModuleBuilderProtocol
    var onboardingBuilder: OnboardingModuleBuilderProtocol
    
    // MARK: - Init
    
    required init(window: UIWindow?,
                  navigationController: UINavigationController,
                  loadingCase: FlowCase,
                  authBuilder: AuthModuleBuilderProtocol,
                  onboardingBuilder: OnboardingModuleBuilderProtocol) {
        self.window = window
        self.navigationController = navigationController
        self.flowCase = loadingCase
        self.authBuilder = authBuilder
        self.onboardingBuilder = onboardingBuilder
    }
}

// MARK: - MainRouterProtocol

extension MainRouter: MainRouterProtocol {
    func initialViewController() {
        goToFlow(flow: flowCase)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func goToFlow(flow: FlowCase) {
        switch flow {
        case .auth:
            showLogin()
        case .onboarding:
            showOnboarding()
        case .mainTabBar:
            showMainTabBar()
        }
    }
}

// MARK: - Helper Functions

extension MainRouter {
    private func showMainTabBar() {
        let mainTabBarController = MainTabBarController()
        self.window?.rootViewController = mainTabBarController
    }
}

// MARK: - AuthRouterProtocol

extension MainRouter: AuthRouterProtocol {
    func showLogin() {
        let loginViewController = authBuilder.createLoginModule(router: self)
        navigationController.viewControllers = [loginViewController]
        window?.rootViewController = navigationController
    }
    
    func showSignUp() {
        let signUpViewController = authBuilder.createSignUpModule(router: self)
        navigationController.pushViewController(signUpViewController, animated: true)
    }
}

// MARK: - AuthRouterProtocol

extension MainRouter: OnboardingRouterProtocol {
    func showOnboarding() {
        let onboardingViewController = onboardingBuilder.createOnboardingModule(router: self)
        navigationController.viewControllers = [onboardingViewController]
        window?.rootViewController = navigationController
    }
}
