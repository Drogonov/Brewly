//
//  SettingsViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    func setSettingsView()
}

class SettingsViewController: UIViewController {
    
    // MARK: - Properties

    var presenter: SettingsPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Settings"
        self.tabBarItem = {
            let title = "Настройки"
            let image = UIImage(systemName: "gearshape")!
            let selectedImage = UIImage(systemName: "gearshape.fill")!
            let item = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
            return item
        }()
    }
}

// MARK: - SignUpViewProtocol

extension SettingsViewController: SettingsViewProtocol {
    func setSettingsView() {
        presenter.setSettingsView()
    }
}
