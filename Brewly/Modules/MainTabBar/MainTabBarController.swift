//
//  MainTabBarController.swift
//  Brewly
//
//  Created by Anton Vlezko on 01.11.2021.
//

import UIKit

enum TabBarItemType {
    case history
    case brew
    case profile
    
    var type: UITabBarItem {
        switch self {
        case .history:
            return UITabBarItem(
                title: "History",
                image: UIImage(systemName: "clock")!,
                selectedImage: UIImage(systemName: "clock.fill")!
            )
            
        case .brew:
            return UITabBarItem(
                title: "Brew",
                image: UIImage(systemName: "cup.and.saucer")!,
                selectedImage: UIImage(systemName: "cup.and.saucer.fill")!
            )
            
        case .profile:
            return UITabBarItem(
                title: "Profile",
                image: UIImage(systemName: "person")!,
                selectedImage: UIImage(systemName: "person.fill")!
            )
        }
    }
}


class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureUI()
    }
    
    // MARK: - External Functions
    
    func configureTabBar(with vcArray: [(vc: UIViewController, tabBarItemType: TabBarItemType)]) {
        viewControllers = vcArray.map { item in
            item.vc.tabBarItem = item.tabBarItemType.type
            let nav = embedToNav(item.vc)
            
            return nav
        }
        selectedIndex = 1
    }
    
    func getNavController<T: UIViewController>(with viewController: T) -> UINavigationController? {
        guard let index = getIndexOfEmbedeWithNavVC(with: viewController),
              let nav = viewControllers?[index] as? UINavigationController else { return nil }
        
        return nav
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .label
//        tabBar.isTranslucent = true
                
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.tabBar.frame
//
//        self.view.addSubview(blurEffectView)
//        self.view.bringSubviewToFront(tabBar)
        
    }
        
    // MARK: - Helper Functions
    
    private func embedToNav(_ viewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: viewController)
    }
    
    private func getIndexOfEmbedeWithNavVC(with viewController: UIViewController) -> Int? {
        viewControllers?.firstIndex(where: {
            isControllersTypeEqual(firstController: $0, secondController: viewController)
        })
    }
    
    private func isControllersTypeEqual(firstController: UIViewController, secondController: UIViewController) -> Bool {
        guard let firstVC = extractLastViewControllerIfItIsNav(viewController: firstController),
              let secondVC = extractLastViewControllerIfItIsNav(viewController: secondController) else { return false }
        
        return type(of: firstVC) == type(of: secondVC)
    }
    
    private func extractLastViewControllerIfItIsNav(viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? UINavigationController else {
            return viewController
        }
        
        return vc.viewControllers.last
    }
}

