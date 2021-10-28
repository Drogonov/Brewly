//
//  MainTabBarController.swift
//  Brewly
//
//  Created by Anton Vlezko on 28.10.2021.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureUI()
    }
    
    // MARK: - Helper Functions
    
    func configureUI() {
        let viewController1 = UIViewController()
        viewController1.view.backgroundColor = .green
        viewController1.tabBarItem.image = UIImage(systemName: "person")!
        
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = .red
        viewController2.tabBarItem.image = UIImage(systemName: "circle")!
        
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .gray
        viewControllers = [viewController1, viewController2]
    }
}
