//
//  HistoryPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import Foundation
import UIKit

protocol HistoryPresenterProtocol: AnyObject {
    init(view: HistoryViewProtocol,
         router: MainTabBarRouterProtocol)
    func setHistoryView()
    func showDetailHistoryView(with _vc: UIViewController)
}

class HistoryPresenter: HistoryPresenterProtocol {
    // MARK: - Properties
    
    weak var view: HistoryViewProtocol?
    var router: MainTabBarRouterProtocol
        
    // MARK: - Init

    required init(view: HistoryViewProtocol,
                  router: MainTabBarRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Protocol Functions

    func setHistoryView() {
        self.view?.setHistoryView()
    }
    
    func showDetailHistoryView(with _vc: UIViewController) {
        self.router.showDetailHistory(with: _vc)
    }
}
