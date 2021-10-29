//
//  HistoryViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import UIKit
import SwiftUI

protocol HistoryViewProtocol: AnyObject {
    func setHistoryView()
}

class HistoryViewController: UIViewController {
    
    // MARK: - Properties

    var presenter: HistoryPresenterProtocol!
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureHistoryView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "History"
        self.tabBarItem = {
            let title = "История"
            let image = UIImage(systemName: "clock")!
            let selectedImage = UIImage(systemName: "clock.fill")!
            let item = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
            return item
        }()
    }
    
    private func configureHistoryView() {
        let historyView = HistoryView(detailButtonTapped: {
            self.presenter.showDetailHistoryView()
        })
        addHistoryViewToVC(historyView: historyView)
    }
    
    private func addHistoryViewToVC(historyView: HistoryView) {
        let historyCtrl = UIHostingController(rootView: historyView)
        addChild(historyCtrl)
        view.addSubview(historyCtrl.view)
        
        historyCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

// MARK: - SignUpViewProtocol

extension HistoryViewController: HistoryViewProtocol {
    func setHistoryView() {
        presenter.setHistoryView()
    }
}
