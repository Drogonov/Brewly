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
        configureBrewView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Brew"
    }
    
    private func configureBrewView() {
        let brewView = BrewView(brewButtonTapped: {
            self.presenter.showBrewConfigurationView(with: self)
        })
        addBrewViewToVC(brewView: brewView)
    }
    
    private func addBrewViewToVC(brewView: BrewView) {
        let brewCtrl = UIHostingController(rootView: brewView)
        addChild(brewCtrl)
        view.addSubview(brewCtrl.view)
        
        brewCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

// MARK: - BrewViewProtocol

extension BrewViewController: BrewViewProtocol {
    func setBrewView() {
        presenter.setBrewView()
    }
}
