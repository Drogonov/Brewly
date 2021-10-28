//
//  OnboardingRouter.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit

protocol OnboardingRouterProtocol: Router {
    var builder: OnboardingModuleBuilderProtocol? { get set }
    
    func showOnboarding()
    func popToRoot()
    
    init(navigationController: UINavigationController,
         builder: OnboardingModuleBuilderProtocol)
}

class OnboardingRouter: OnboardingRouterProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController?
    var builder: OnboardingModuleBuilderProtocol?
    
    // MARK: - Init
    
    required init(navigationController: UINavigationController,
                  builder: OnboardingModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    // MARK: - Protocol Functions
    
    func showOnboarding() {
        if let navigationController = navigationController {
            guard let onboardingViewController = builder?.createOnboardingModule(router: self) else { return }
            navigationController.viewControllers = [onboardingViewController]
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
