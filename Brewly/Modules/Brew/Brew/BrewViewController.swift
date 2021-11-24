//
//  BrewViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import UIKit
import SwiftUI

protocol BrewViewProtocol: AnyObject {
    func setBrewView()
}

class BrewViewController: BaseViewController {
    
    // MARK: - Properties
        
    var presenter: BrewPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Configure UI

extension BrewViewController {
    private func configureUI() {
        presenter?.setBrewView()
    }
    
    private func configureView(with model: AuthViewModel) {
        let view = BrewView(brewButtonTapped: {
            self.presenter.showBrewConfigurationView(with: self)
        })
        addMainViewToViewController(view)
    }
}

// MARK: - BrewViewProtocol

extension BrewViewController: BrewViewProtocol {
    func setBrewView() {
        setNavigationBarTitle(with: "Brew")
        presenter.setBrewView()
    }
}
