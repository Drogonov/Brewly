//
//  AuthRouter.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit

protocol AuthRouterProtocol: Router {
    var builder: AuthModuleBuilderProtocol? { get set }
    
    func showLogin()
    func showSignUp()
    func popToRoot()
    func goToFlow(flow: FlowCase)
    
    init(navigationController: UINavigationController,
         builder: AuthModuleBuilderProtocol)
}

class AuthRouter: AuthRouterProtocol {
    
    // MARK: - Properties
    
    weak var delegate: ChangeFlowRouterDelegate?
    
    var navigationController: UINavigationController?
    var builder: AuthModuleBuilderProtocol?
    
    // MARK: - Init
    
    required init(navigationController: UINavigationController,
                  builder: AuthModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    // MARK: - Protocol Functions
    
    func showLogin() {
        if let navigationController = navigationController {
            guard let loginViewController = builder?.createLoginModule(router: self) else { return }
            navigationController.viewControllers = [loginViewController]
        }
    }
    
    func showSignUp() {
        if let navigationController = navigationController {
            guard let signUpViewController = builder?.createLoginModule(router: self) else { return }
            navigationController.pushViewController(signUpViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func goToFlow(flow: FlowCase) {
        delegate?.goToFlow(flow: flow)
    }
}
