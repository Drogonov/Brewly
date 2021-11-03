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

class BrewConfigurationViewController: UIViewController {
    
    // MARK: - Properties
        
    var presenter: BrewConfigurationPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureBrewConfigurationView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Brew"
    }
    
    private func configureBrewConfigurationView() {
        let brewConfigurationView = BrewConfigurationView(createBrewTapped: {
            self.presenter.showBrewListView(with: self)
        })
        addBrewConfigurationViewToVC(brewConfigurationView: brewConfigurationView)
    }
    
    private func addBrewConfigurationViewToVC(brewConfigurationView: BrewConfigurationView) {
        let brewConfigurationCtrl = UIHostingController(rootView: brewConfigurationView)
        addChild(brewConfigurationCtrl)
        view.addSubview(brewConfigurationCtrl.view)
        
        brewConfigurationCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

// MARK: - BrewConfigurationViewProtocol

extension BrewConfigurationViewController: BrewConfigurationViewProtocol {
    func setBrewConfigurationView() {
        presenter.setBrewConfigurationView()
    }
}
