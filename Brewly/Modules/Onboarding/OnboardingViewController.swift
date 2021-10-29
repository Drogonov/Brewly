//
//  OnboardingViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit
import SwiftUI

protocol OnboardingViewProtocol: AnyObject {
    func setOnboardingView()
}

class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: OnboardingPresenterProtocol!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Configure UI

extension OnboardingViewController {
    private func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        configureNavigationBar()
        configureOnboardingView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Onboarding"
    }
    
    private func configureOnboardingView() {
        let onboardingView = OnboardingView(onboardingButtonTapped: {
            self.presenter.changeFlow(flow: .auth)
        }, mainTabBarButtonTapped: {
            self.presenter.changeFlow(flow: .mainTabBar)
        })
        addOnboardingViewToVC(onboardingView: onboardingView)
    }
    
    private func addOnboardingViewToVC(onboardingView: OnboardingView) {
        let onboardingCtrl = UIHostingController(rootView: onboardingView)
        addChild(onboardingCtrl)
        view.addSubview(onboardingCtrl.view)
        
        onboardingCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

// MARK: - LoginViewProtocol

extension OnboardingViewController: OnboardingViewProtocol {
    func setOnboardingView() {
        presenter.setOnboardingView()
    }
}
