//
//  Extensions.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import Foundation

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
