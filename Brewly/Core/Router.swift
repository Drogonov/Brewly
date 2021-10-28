//
//  Router.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit

enum FlowCase {
    case auth
    case onboarding
    case mainTabBar
}

protocol Router {
    var navigationController: UINavigationController? { get set }
}

protocol ChangeFlowRouterDelegate: AnyObject {
    func goToFlow(flow: FlowCase)
}

protocol MainRouterProtocol: Router {
    var window: UIWindow? { get set }
    var flowCase: FlowCase { get set }
    
    func initialViewController()
    
    init(window: UIWindow?,
         navigationController: UINavigationController,
         loadingCase: FlowCase)
}

class MainRouter: MainRouterProtocol {
    
    // MARK: - Properties

    var window: UIWindow?
    var navigationController: UINavigationController?
    var flowCase: FlowCase
    
    let builder = AuthModuleBuilder()
    var authRouter: AuthRouter!
    
    // MARK: - Init

    required init(window: UIWindow?,
                  navigationController: UINavigationController,
                  loadingCase: FlowCase) {
        self.window = window
        self.navigationController = navigationController
        self.flowCase = loadingCase
        

        authRouter = AuthRouter(navigationController: navigationController,
                                builder: builder)
        authRouter.delegate = self
    }
    
    // MARK: - Protocol Functions

    func initialViewController() {
        switch flowCase {
        case .auth:
            showAuthFlow()
        case .onboarding:
            showOnboardingFlow()
        case .mainTabBar:
            showMainTabBar()
        }
    }
    
    // MARK: - Helper Functions

    private func showAuthFlow() {
        authRouter.showLogin()
    }
    
    private func showOnboardingFlow() {
        if let navigationController = navigationController {
            let builder = OnboardingModuleBuilder()
            let router = OnboardingRouter(navigationController: navigationController,
                                    builder: builder)
            router.delegate = self
            router.showOnboarding()
        }
    }
    
    private func showMainTabBar() {
        let mainTabBarController = MainTabBarController()
        self.window?.rootViewController = mainTabBarController
    }
}

extension MainRouter: ChangeFlowRouterDelegate {
    func goToFlow(flow: FlowCase) {
        self.flowCase = flow
        debugPrint("123")
        initialViewController()
    }
}
