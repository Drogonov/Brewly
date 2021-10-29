//
//  DetailHistoryViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import UIKit
import SwiftUI

protocol DetailHistoryViewProtocol: AnyObject {
    func setDetailHistoryView()
}

class DetailHistoryViewController: UIViewController {
    
    // MARK: - Properties

    var presenter: DetailHistoryPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureDetailHistoryView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Детали"
    }
    
    private func configureDetailHistoryView() {
        let detailHistoryView = DetailHistoryView(loginButtonTapped: {
            self.presenter.changeFlow(flow: .auth)
        })
        addDetailHistoryViewToVC(detailHistoryView: detailHistoryView)
    }
    
    private func addDetailHistoryViewToVC(detailHistoryView: DetailHistoryView) {
        let detailHistoryCtrl = UIHostingController(rootView: detailHistoryView)
        addChild(detailHistoryCtrl)
        view.addSubview(detailHistoryCtrl.view)
        
        detailHistoryCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

// MARK: - SignUpViewProtocol

extension DetailHistoryViewController: DetailHistoryViewProtocol {
    func setDetailHistoryView() {
        presenter.setDetailHistoryView()
    }
}
