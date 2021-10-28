//
//  OnboardingPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import Foundation

protocol OnboardingPresenterProtocol: AnyObject {
    init(view: OnboardingViewProtocol,
         router: OnboardingRouterProtocol)
    func setOnboardingView()
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: OnboardingViewProtocol?
    var router: OnboardingRouterProtocol
    
    // MARK: - Init
    
    required init(view: OnboardingViewProtocol,
                  router: OnboardingRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Protocol Functions
    
    func setOnboardingView() {
        self.view?.setOnboardingView()
    }
}
