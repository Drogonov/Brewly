//
//  BrewConfigurationModel.swift
//  Brewly
//
//  Created by Anton Vlezko on 24.11.2021.
//

import Foundation

struct BrewConfigurationModel {
    let id = UUID()
    let cappingName: String
    let amountOfSamples: Int
    let comment: String
}
