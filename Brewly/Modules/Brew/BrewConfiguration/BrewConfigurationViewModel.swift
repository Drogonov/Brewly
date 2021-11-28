//
//  BrewConfigurationViewModel.swift
//  Brewly
//
//  Created by Anton Vlezko on 27.11.2021.
//

import Foundation

class BrewConfigurationViewModel: ObservableObject {
    
    // MARK: - Placeholders
    
    let cappingNamePlaceholder: String = "Capping Name"
    let isBlindPlaceholder: String = "Is capping blind?"
    let isSocialPlaceholder: String = "Is capping social?"
    let amountOfSamplesPlaceholder: String = "Amount of samples"
    let commentPlaceholder: String = "Amount of samples"
    
    var namePlaceholder: String = "Sample "
    var roastDatePlaceholder: String = "Roast Date"
    var blindNumberPlaceholder: String = "Blind Number"
    
    // MARK: - Values
    
    @Published var navigationTitle: String = "Brew Configuration"
    
    @Published var cappingName: String = ""
    @Published var isBlind: Bool = true
    @Published var isSocial: Bool = false
    @Published var amountOfSamples: Int? = nil
    @Published var comment: String = ""

    @Published var samplesArray: [BrewConfigurationSampleViewModel] = []
    @Published var brewConfigurationButtonText: String = "Let's Brew!"
}
