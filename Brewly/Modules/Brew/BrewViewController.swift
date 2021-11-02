//
//  BrewViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import UIKit

protocol BrewViewProtocol: AnyObject {
    func setBrewView()
}

class BrewViewController: UIViewController {
    
    // MARK: - Properties
        
    var presenter: BrewPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Brew"
    }
}

// MARK: - BrewViewProtocol

extension BrewViewController: BrewViewProtocol {
    func setBrewView() {
        presenter.setBrewView()
    }
}
