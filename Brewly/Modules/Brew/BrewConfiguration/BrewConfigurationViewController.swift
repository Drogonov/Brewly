//
//  BrewConfigurationViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import UIKit
import SwiftUI

protocol BrewConfigurationViewProtocol: AnyObject {
    func setBrewConfigurationView()
}

class BrewConfigurationViewController: BaseViewController {
    
    // MARK: - Properties
        
    var presenter: BrewConfigurationPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Configure UI

extension BrewConfigurationViewController {
    private func configureUI() {
        presenter?.setBrewConfigurationView()
    }
    
    private func configureView() {
        let view = BrewConfigurationView(createBrewTapped: {
            self.presenter.showBrewListView(with: self)
        })
        addMainViewToViewController(view)
    }
}

// MARK: - BrewConfigurationViewProtocol

extension BrewConfigurationViewController: BrewConfigurationViewProtocol {
    func setBrewConfigurationView() {
        setNavigationBarTitle(with: "Brew Configuration")
        configureView()
    }
}
