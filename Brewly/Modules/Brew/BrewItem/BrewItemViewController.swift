//
//  BrewItemViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 08.11.2021.
//

import UIKit
import SwiftUI

protocol BrewItemViewProtocol: AnyObject {
    func setBrewItemView()
}

class BrewItemViewController: UIViewController {
    
    // MARK: - Properties
        
    var presenter: BrewItemPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureBrewItemView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Brew Item"
    }
    
    private func configureBrewItemView() {
        let brewItemView = BrewItemView()
        addBrewItemViewToVC(brewItemView: brewItemView)
    }
    
    private func addBrewItemViewToVC(brewItemView: BrewItemView) {
        let brewItemCtrl = UIHostingController(rootView: brewItemView)
        addChild(brewItemCtrl)
        view.addSubview(brewItemCtrl.view)
        
        brewItemCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

// MARK: - BrewConfigurationViewProtocol

extension BrewItemViewController: BrewItemViewProtocol {
    func setBrewItemView() {
        presenter.setBrewItemView()
    }
}
