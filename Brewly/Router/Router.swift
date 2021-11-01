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
    var tabBarController: MainTabBarController
    
    var flowCase: FlowCase
    
    var authBuilder: AuthModuleBuilderProtocol
    var onboardingBuilder: OnboardingModuleBuilderProtocol
    var mainTabBarBuilder: MainTabBarBuilderProtocol
    
    // MARK: - Init
    
    required init(
        window: UIWindow?,
        navigationController: UINavigationController = UINavigationController(),
        tabBarController: MainTabBarController = MainTabBarController(),
        flowCase: FlowCase,
        authBuilder: AuthModuleBuilderProtocol = AuthModuleBuilder(),
        onboardingBuilder: OnboardingModuleBuilderProtocol = OnboardingModuleBuilder(),
        mainTabBarBuilder: MainTabBarBuilderProtocol = MainTabBarBuilder()
    ) {
        self.window = window
        self.navigationController = navigationController
        self.tabBarController = tabBarController
        
        self.flowCase = flowCase
        
        self.authBuilder = authBuilder
        self.onboardingBuilder = onboardingBuilder
        self.mainTabBarBuilder = mainTabBarBuilder
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

// MARK: - MainTabBarRouterProtocol

extension MainRouter: MainTabBarRouterProtocol {
    func showMainTabBar() {
        let historyController = mainTabBarBuilder.createHistoryModule(router: self)
        let settingsController = mainTabBarBuilder.createSettingsModule(router: self)
        tabBarController.configureTabBar(with: [historyController, settingsController])
        self.window?.rootViewController = tabBarController
    }
    
    func showDetailHistory() {
        let detailViewController = mainTabBarBuilder.createDetailHistoryModule(router: self)
        guard let navController = tabBarController.getNavController(with: HistoryViewController()) else { return }
        navController.pushViewController(detailViewController, animated: true)
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
