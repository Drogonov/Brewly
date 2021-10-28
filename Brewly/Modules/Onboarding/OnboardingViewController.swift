//
//  OnboardingViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    func setOnboardingView()
}

class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: OnboardingPresenterProtocol!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

// MARK: - LoginViewProtocol

extension OnboardingViewController: OnboardingViewProtocol {
    func setOnboardingView() {
        presenter.setOnboardingView()
    }
}
