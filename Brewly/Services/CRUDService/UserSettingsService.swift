//
//  UserSettingsService.swift
//  Brewly
//
//  Created by Anton Vlezko on 19.11.2021.
//

import Foundation

protocol UserSettingsServiceProtocol {
    func onboardingWasShown()
    func shouldOnboardingBeShown() -> Bool
    func loadUserSettings() -> UserSettings
    func setDefaultUserSetting() -> UserSettings
    func saveUserSetting(with settings: UserSettings)
}

class UserSettingsService: Injectable {
    
    // MARK: - Properties
    
    private let userSettingKey = "userSettings"
    
    // MARK: - Construction
    
    init() {}
}

// MARK: - UserSettingsServiceProtocol

extension UserSettingsService: UserSettingsServiceProtocol {
    func onboardingWasShown() {
        var userSettings = loadUserSettings()
        userSettings.shouldShowOnboarding = false
        saveUserSetting(with: userSettings)
    }
    
    func shouldOnboardingBeShown() -> Bool {
        let userSettings = loadUserSettings()
        return userSettings.shouldShowOnboarding
    }
    
    func loadUserSettings() -> UserSettings {
        guard let data = UserDefaults.standard.value(forKey: userSettingKey) as? Data else {
            let userSettings = setDefaultUserSetting()
            return userSettings
        }
        
        guard let userSettings = try? PropertyListDecoder().decode(UserSettings.self, from: data) else {
            let userSettings = setDefaultUserSetting()
            return userSettings
        }
        
        return userSettings
    }
    
    func setDefaultUserSetting() -> UserSettings {
        let userSettings = UserSettings(
            flowCase: .mainTabBar,
            shouldShowOnboarding: true
        )
        saveUserSetting(with: userSettings)
        return userSettings
    }
    
    func saveUserSetting(with settings: UserSettings) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(settings), forKey: userSettingKey)
    }
}
