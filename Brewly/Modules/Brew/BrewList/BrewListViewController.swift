//
//  BrewListViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import UIKit
import SwiftUI

protocol BrewListViewProtocol: AnyObject {
    func setBrewListView()
}

class BrewListViewController: BaseViewController {
    
    // MARK: - Properties
        
    var presenter: BrewListPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Configure UI

extension BrewListViewController {
    private func configureUI() {
        setNavigationBarTitle(with: "Brew List")
        presenter.setBrewListView()
    }
    
    private func configureView() {
        let view = BrewListView(brewCellTapped: {
            self.presenter.showBrewItemView(with: self)
        })
        addMainViewToViewController(view)
    }
}

// MARK: - BrewConfigurationViewProtocol

extension BrewListViewController: BrewListViewProtocol {
    func setBrewListView() {
        configureView()
    }
}
