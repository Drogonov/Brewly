//
//  BrewListViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 27.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol BrewListViewControllerProtocol: AnyObject {
    func setView(with viewModel: BrewListViewModel)
    
}

class BrewListViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: BrewListPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Configure UI

extension BrewListViewController {
    private func configureUI() {
        presenter?.setView()
    }
    
    private func configureView(with viewModel: BrewListViewModel) {
        let view = BrewListView(
            brewCellTapped: {
                self.presenter?.brewCellTapped(with: self)
            }
        )
        addMainViewToViewController(view)
    }
}

// MARK: - BrewViewProtocol

extension BrewListViewController: BrewListViewControllerProtocol {
    func setView(with viewModel: BrewListViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}
