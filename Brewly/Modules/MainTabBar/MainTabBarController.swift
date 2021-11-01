//
//  MainTabBarController.swift
//  Brewly
//
//  Created by Anton Vlezko on 01.11.2021.
//

import UIKit

enum TabBarItemType {
    
}


class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureUI()
    }
    
    // MARK: - External Functions
    
    func configureTabBar(with _vcArray: [UIViewController]) {
        viewControllers = _vcArray.map { vc in
            vc.tabBarItem = {
                let title = "История"
                let image = UIImage(systemName: "clock")!
                let selectedImage = UIImage(systemName: "clock.fill")!
                let item = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
                return item
            }()
            
            
            let nav = embedToNav(vc)
            
            
            
            return nav
        }
    }
    
    func getNavController<T: UIViewController>(with _viewController: T) -> UINavigationController? {
        guard let index = getIndexOfEmbedeWithNavVC(with: _viewController),
              let nav = viewControllers?[index] as? UINavigationController else { return nil }
        
        return nav
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .label
    }
        
    // MARK: - Helper Functions
    
    private func embedToNav(_ viewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: viewController)
    }
    
    private func getIndexOfEmbedeWithNavVC(with _viewController: UIViewController) -> Int? {
        viewControllers?.firstIndex(where: {
            isControllersTypeEqual(firstController: $0, secondController: _viewController)
        })
    }
    
    private func isControllersTypeEqual(firstController: UIViewController, secondController: UIViewController) -> Bool {
        guard let firstVC = extractViewControllerIfItIsNav(viewController: firstController),
              let secondVC = extractViewControllerIfItIsNav(viewController: secondController) else { return false }
        
        return type(of: firstVC) == type(of: secondVC)
    }
    
    private func extractViewControllerIfItIsNav(viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? UINavigationController else {
            return viewController
        }
        
        return vc.viewControllers.first
    }
    

}

