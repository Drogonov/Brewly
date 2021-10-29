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
    
    init(window: UIWindow?,
         navigationController: UINavigationController,
         loadingCase: FlowCase,
         authBuilder: AuthModuleBuilderProtocol,
         onboardingBuilder: OnboardingModuleBuilderProtocol)
}

protocol AuthRouterProtocol: Router {
    var authBuilder: AuthModuleBuilderProtocol { get set }
    
    func showLogin()
    func showSignUp()
}

protocol OnboardingRouterProtocol: Router {
    var onboardingBuilder: OnboardingModuleBuilderProtocol { get set }
    
    func showOnboarding()
}
