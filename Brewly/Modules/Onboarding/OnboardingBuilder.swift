//
//  OnboardingBuilder.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit

protocol OnboardingModuleBuilderProtocol {
    func createOnboardingModule(router: OnboardingRouterProtocol) -> UIViewController
}

class OnboardingModuleBuilder: OnboardingModuleBuilderProtocol {
    @Inject var userSettingsService: UserSettingsService

    func createOnboardingModule(router: OnboardingRouterProtocol) -> UIViewController {
        let view = OnboardingViewController()
        let presenter = OnboardingPresenter(view: view,
                                            router: router)
        view.presenter = presenter
        userSettingsService.onboardingWasShown()
        return view
    }
}
