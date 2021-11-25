//
//  BrewViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import UIKit
import SwiftUI

protocol BrewViewProtocol: AnyObject {
    func setBrewView(with model: BrewViewModel)
}

class BrewViewController: BaseViewController {
    
    // MARK: - Properties
        
    var presenter: BrewPresenterProtocol?
    
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
    
    private func configureView(with model: BrewViewModel) {
        let view = BrewView(brewButtonText: model.brewButtonText,
                            brewButtonTapped: {
            self.presenter?.showBrewConfigurationView(with: self)
        })
        addMainViewToViewController(view)
    }
}

// MARK: - BrewViewProtocol

extension BrewViewController: BrewViewProtocol {
    func setBrewView(with model: BrewViewModel) {
        setNavigationBarTitle(with: model.navigationTitle)
        configureView(with: model)
    }
}
