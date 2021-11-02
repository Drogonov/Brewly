//
//  ProfileViewController.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func setProfileView()
}

class ProfileViewController: UIViewController {
    
    // MARK: - Properties

    var presenter: ProfilePresenterProtocol!
    
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
    }
}

// MARK: - SignUpViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    func setProfileView() {
        presenter.setProfileView()
    }
}
