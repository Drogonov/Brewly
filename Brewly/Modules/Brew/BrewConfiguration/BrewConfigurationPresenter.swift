//
//  BrewConfigurationPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import SwiftUI
import UIKit

protocol BrewConfigurationPresenterProtocol: AnyObject {
    var viewModel: BrewConfigurationViewModel { get set }
    init(
        view: BrewConfigurationViewProtocol,
        router: MainTabBarRouterProtocol
    )
    func setBrewConfigurationView()
    func showBrewListView(
        with tuple: (
            cappingName: String, amountOfSamples: Int, comment: String
        ),
        and vc: UIViewController
    )
    func amountOfSamplesChanged(with amountOfSamples: Int?)
}

class BrewConfigurationPresenter: ObservableObject {
    
    // MARK: - Servicess
    
    // MARK: - Properties
    
    weak var view: BrewConfigurationViewProtocol?
    var router: MainTabBarRouterProtocol
    @ObservedObject var viewModel = BrewConfigurationViewModel()
    
    // MARK: - Init
    
    required init(
        view: BrewConfigurationViewProtocol,
        router: MainTabBarRouterProtocol
    ) {
        self.view = view
        self.router = router
    }
}

// MARK: - BrewConfigurationPresenterProtocol

extension BrewConfigurationPresenter: BrewConfigurationPresenterProtocol {
    func setBrewConfigurationView() {
        self.view?.setBrewConfigurationView(with: viewModel)
    }
    
    func showBrewListView(with tuple: (cappingName: String, amountOfSamples: Int, comment: String), and vc: UIViewController) {
        let model = BrewConfigurationModel(
            cappingName: tuple.cappingName,
            amountOfSamples: tuple.amountOfSamples,
            comment: tuple.comment
        )
        self.router.showBrewList(with: model, and: vc)
    }
    
    func amountOfSamplesChanged(with amountOfSamples: Int?) {
        configureSamplesArray(with: amountOfSamples)
        self.view?.setBrewConfigurationView(with: viewModel)
    }
}

// MARK: - Helper Functions

extension BrewConfigurationPresenter {
    func clearViewModel() {
        viewModel = BrewConfigurationViewModel()
    }
    
    func configureSamplesArray(with amountOfSamples: Int?) {
        guard let amountOfSamples = amountOfSamples else {
            viewModel.samplesArray = []
            return
        }
        
        if amountOfSamples > viewModel.samplesArray.count {
            let newElementsAmount = amountOfSamples - viewModel.samplesArray.count
            
            for i in 0..<newElementsAmount {
                let sample = BrewConfigurationSampleViewModel(
                    name: "Sample \(i + 1)",
                    roastDate: "\(Date())",
                    blindNumber: i + 1
                )
                viewModel.samplesArray.append(sample)
            }
        }
        
        if amountOfSamples < viewModel.samplesArray.count {
            let elementsToDelete = viewModel.samplesArray.count - amountOfSamples
            
            for _ in 0..<elementsToDelete {
                viewModel.samplesArray.removeLast()
            }
        }
        
        self.viewModel = viewModel
    }
}
