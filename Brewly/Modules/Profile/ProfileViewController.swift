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
    
    @Inject var firebaseService: FirebaseService
    @Inject var userSettingsService: UserSettingsService
    
    var presenter: ProfilePresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func signOut() {
        firebaseService.signOut { wasUserSignOut in
            debugPrint("DEBUG: user sign out \(wasUserSignOut)")
        }
    }
    
    @objc func watchOnboarding() {
        var settings = userSettingsService.loadUserSettings()
        settings.shouldShowOnboarding = true
        userSettingsService.saveUserSetting(with: settings)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sign Out",
            style: .plain,
            target: self,
            action: #selector(signOut)
        )
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "See onboarding",
            style: .plain,
            target: self,
            action: #selector(watchOnboarding)
        )
    }
}

// MARK: - SignUpViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    func setProfileView() {
        presenter.setProfileView()
    }
}
