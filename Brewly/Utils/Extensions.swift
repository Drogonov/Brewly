//
//  Extensions.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import Foundation
import SwiftUI

extension Int {
    var numberToString: String {
        return String(self)
    }
}

extension String {
    var stringToNumber: Int? {
        return Int(self)
    }
}

extension Color {
    static let backgroundColor = Color(UIColor.backgroundColor)
    
    static let primaryTextColor = Color(UIColor.primaryTextColor)
    static let secondaryTextColor = Color(UIColor.secondaryTextColor)
    
    static let actionButtonTextColor = Color(UIColor.actionButtonTextColor)
    static let actionButtonBackgroundColor = Color(UIColor.actionButtonBackgroundColor)
    
    static let accentColor = Color(UIColor.accentColor)
}

extension UIColor {
    static let backgroundColor = UIColor.systemBackground
    
    static let primaryTextColor = UIColor.label
    static let secondaryTextColor = UIColor.gray
    
    static let actionButtonTextColor = UIColor.systemBackground
    static let actionButtonBackgroundColor = UIColor.label
    
    static let hologramColor1 = UIColor(patternImage: UIImage(named: "hologram_1")!)
    static let hologramColor2 = UIColor(patternImage: UIImage(named: "hologram_2")!)
    
    static let accentColor = UIColor.red
}
