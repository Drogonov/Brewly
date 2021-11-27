//
//  BrewConfigurationViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import UIKit
import SwiftUI

protocol BrewConfigurationViewProtocol: AnyObject {
    func setBrewConfigurationView(with viewModel: BrewConfigurationViewModel)
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
        view.backgroundColor = UIColor.systemGroupedBackground
        presenter?.setBrewConfigurationView()
    }
    
    private func configureView(with viewModel: BrewConfigurationViewModel) {
        let view = BrewConfigurationView(
            brewConfigurationButtonText: viewModel.brewConfigurationButtonText,
            createBrewTapped: { cappingName, amountOfSamples, comment in
                let tuple: (
                    cappingName: String, amountOfSamples: Int, comment: String
                ) = (
                    cappingName, amountOfSamples, comment
                )
                self.presenter.showBrewListView(with: tuple, and: self)
            }
        )
        addMainViewToViewController(view)
    }
}

// MARK: - BrewConfigurationViewProtocol

extension BrewConfigurationViewController: BrewConfigurationViewProtocol {
    func setBrewConfigurationView(with viewModel: BrewConfigurationViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}
