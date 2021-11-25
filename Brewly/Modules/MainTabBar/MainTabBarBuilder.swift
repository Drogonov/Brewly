//
//  MainTabBarBuilder.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import UIKit

protocol MainTabBarBuilderProtocol {
    var historyBuilder: HistoryBuilderProtocol { get set }
    var brewBuilder: BrewBuilderProtocol { get set }
    var profileBuilder: ProfileBuilderProtocol { get set }
    
    init(
        historyBuilder: HistoryBuilderProtocol,
        brewBuilder: BrewBuilderProtocol,
        profileBuilder: ProfileBuilderProtocol
    )
}

class MainTabBarBuilder: MainTabBarBuilderProtocol {
    var historyBuilder: HistoryBuilderProtocol
    var brewBuilder: BrewBuilderProtocol
    var profileBuilder: ProfileBuilderProtocol
    
    required init(
        historyBuilder: HistoryBuilderProtocol = HistoryBuilder(),
        brewBuilder: BrewBuilderProtocol = BrewBuilder(),
        profileBuilder: ProfileBuilderProtocol = ProfileBuilder()
    ) {
        self.historyBuilder = historyBuilder
        self.brewBuilder = brewBuilder
        self.profileBuilder = profileBuilder
    }
}

