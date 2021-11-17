//
//  RouterProtocols.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import UIKit

protocol Router {
    var navigationController: UINavigationController { get set }
    func goToFlow(flow: FlowCase)
}

protocol MainRouterProtocol: Router {
    var window: UIWindow? { get set }
    var flowCase: FlowCase { get set }
    
    func initialViewController()
    func popToRoot()
    func popViewController()
    
    init(window: UIWindow?,
         navigationController: UINavigationController,
         tabBarController: MainTabBarController,
         flowCase: FlowCase,
         authBuilder: AuthModuleBuilderProtocol,
         onboardingBuilder: OnboardingModuleBuilderProtocol,
         mainTabBarBuilder: MainTabBarBuilderProtocol)
}

protocol AuthRouterProtocol: Router {
    var authBuilder: AuthModuleBuilderProtocol { get set }
    
    func showLogin()
    func showSignUp()
    func showAuthWithEmail(model: AuthWithEmailViewModel)
    func popViewController()
}

protocol OnboardingRouterProtocol: Router {
    var onboardingBuilder: OnboardingModuleBuilderProtocol { get set }
    
    func showOnboarding()
}

protocol MainTabBarRouterProtocol: Router {
    var tabBarController: MainTabBarController { get set }
    var mainTabBarBuilder: MainTabBarBuilderProtocol { get set }
    
    func showMainTabBar()
    func showDetailHistory(with _vc: UIViewController)
    func showBrewConfiguration(with _vc: UIViewController)
    func showBrewList(with _vc: UIViewController)
    func showBrewItem(with _vc: UIViewController)
}
