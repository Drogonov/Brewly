//
//  DetailHistoryPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import Foundation

protocol DetailHistoryPresenterProtocol: AnyObject {
    init(view: DetailHistoryViewProtocol,
         router: MainTabBarRouterProtocol)
    func setDetailHistoryView()
    func changeFlow(flow: FlowCase)
}

class DetailHistoryPresenter: DetailHistoryPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: DetailHistoryViewProtocol?
    var router: MainTabBarRouterProtocol
        
    // MARK: - Init

    required init(view: DetailHistoryViewProtocol,
                  router: MainTabBarRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Protocol Functions

    func setDetailHistoryView() {
        self.view?.setDetailHistoryView()
    }
    
    func changeFlow(flow: FlowCase) {
        router.goToFlow(flow: flow)
    }

}
