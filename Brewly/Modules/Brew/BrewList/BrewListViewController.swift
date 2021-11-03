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

class BrewListViewController: UIViewController {
    
    // MARK: - Properties
        
    var presenter: BrewListPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureBrewListView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Brew List"
    }
    
    private func configureBrewListView() {
        let brewListView = BrewListView()
        addBrewListViewToVC(brewListView: brewListView)
    }
    
    private func addBrewListViewToVC(brewListView: BrewListView) {
        let brewListCtrl = UIHostingController(rootView: brewListView)
        addChild(brewListCtrl)
        view.addSubview(brewListCtrl.view)
        
        brewListCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

// MARK: - BrewConfigurationViewProtocol

extension BrewListViewController: BrewListViewProtocol {
    func setBrewListView() {
        presenter.setBrewListView()
    }
}
