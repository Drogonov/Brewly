//
//  Router.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit

class MainRouter {
    
    // MARK: - Properties
    
    @Inject var userSettingsService: UserSettingsService
    
    var window: UIWindow?
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    var authBuilder: AuthModuleBuilderProtocol
    var onboardingBuilder: OnboardingModuleBuilderProtocol
    var mainTabBarBuilder: MainTabBarBuilderProtocol
    
    // MARK: - Init
    
    required init(
        window: UIWindow?,
        navigationController: UINavigationController = UINavigationController(),
        tabBarController: MainTabBarController = MainTabBarController(),
        authBuilder: AuthModuleBuilderProtocol = AuthModuleBuilder(),
        onboardingBuilder: OnboardingModuleBuilderProtocol = OnboardingModuleBuilder(),
        mainTabBarBuilder: MainTabBarBuilderProtocol = MainTabBarBuilder()
    ) {
        self.window = window
        self.navigationController = navigationController
        self.tabBarController = tabBarController
        self.authBuilder = authBuilder
        self.onboardingBuilder = onboardingBuilder
        self.mainTabBarBuilder = mainTabBarBuilder
    }
}

// MARK: - MainRouterProtocol

extension MainRouter: MainRouterProtocol {
    func initialViewController() {
        let flow = userSettingsService.loadUserSettings()
        goToFlow(flow: flow.flowCase)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func goToFlow(flow: FlowCase) {
        var settings = userSettingsService.loadUserSettings()
        settings.flowCase = flow
        userSettingsService.saveUserSetting(with: settings)
        
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
        let brewController = mainTabBarBuilder.createBrewModule(router: self)
        let profileController = mainTabBarBuilder.createProfileModule(router: self)
        
        let vcArray: [(vc: UIViewController, tabBarItemType: TabBarItemType)] = [
            (vc: historyController, tabBarItemType: .history),
            (vc: brewController, tabBarItemType: .brew),
            (vc: profileController, tabBarItemType: .profile)
        ]
        
        tabBarController.configureTabBar(with: vcArray)
        self.window?.rootViewController = tabBarController
    }
    
    func showDetailHistory(with _vc: UIViewController) {
        let detailViewController = mainTabBarBuilder.createDetailHistoryModule(router: self)
        guard let navController = tabBarController.getNavController(with: _vc) else { return }
        navController.pushViewController(detailViewController, animated: true)
    }
    
    func showBrewConfiguration(with _vc: UIViewController) {
        let brewConfigurationViewController = mainTabBarBuilder.createBrewConfigurationModule(router: self)
        guard let navController = tabBarController.getNavController(with: _vc) else { return }
        navController.pushViewController(brewConfigurationViewController, animated: true)
    }
    
    func showBrewList(with _vc: UIViewController) {
        let brewListViewController = mainTabBarBuilder.createBrewListModule(router: self)
        guard let navController = tabBarController.getNavController(with: _vc) else { return }
        navController.pushViewController(brewListViewController, animated: true)
    }
    
    func showBrewItem(with _vc: UIViewController) {
        let brewItemViewController = mainTabBarBuilder.createBrewItemModule(router: self)
        guard let navController = tabBarController.getNavController(with: _vc) else { return }
        navController.pushViewController(brewItemViewController, animated: true)
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
    
    func showAuthWithEmail(model: AuthWithEmailViewModel) {
        let authWithEmailViewController = authBuilder.createAuthWithEmailModule(
            router: self,
            model: model
        )
        navigationController.pushViewController(authWithEmailViewController, animated: true)
    }
    
    func routeToApp() {
        let settings = userSettingsService.loadUserSettings()
        if settings.shouldShowOnboarding {
            goToFlow(flow: .onboarding)
        } else {
            goToFlow(flow: .mainTabBar)
        }
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
