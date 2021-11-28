//
//  BrewConfigurationPresenter.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import UIKit

protocol BrewConfigurationPresenterProtocol: AnyObject {
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

class BrewConfigurationPresenter {
    
    // MARK: - Services
    
    // MARK: - Properties
    
    weak var view: BrewConfigurationViewProtocol?
    var router: MainTabBarRouterProtocol
    var samplesArray: [BrewConfigurationSampleModel] = []
    
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
        let viewModel = configureViewModel()
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
        setBrewConfigurationView()
    }
}

// MARK: - Helper Functions

extension BrewConfigurationPresenter {
    func configureViewModel() -> BrewConfigurationViewModel {
        return BrewConfigurationViewModel(
            navigationTitle: "Brew Configuration",
            samplesArray: samplesArray,
            brewConfigurationButtonText: "Let's Brew!"
        )
    }
    
    func configureSamplesArray(with amountOfSamples: Int?) {
        guard let amountOfSamples = amountOfSamples else {
            samplesArray = []
            return
        }
        
        if amountOfSamples > samplesArray.count {
            let newElementsAmount = amountOfSamples - samplesArray.count
            
            for i in 0..<newElementsAmount {
                var sample = BrewConfigurationSampleModel()
                sample.blindNumber = i
                samplesArray.append(sample)
            }
        }
        
        if amountOfSamples < samplesArray.count {
            let elementsToDelete = samplesArray.count - amountOfSamples
            
            for _ in 0..<elementsToDelete {
                samplesArray.removeLast()
            }
        }
    }
}
