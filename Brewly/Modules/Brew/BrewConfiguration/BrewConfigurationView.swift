//
//  BrewConfigurationView.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import SwiftUI

struct BrewConfigurationView: View {
    @ObservedObject var viewModel: BrewConfigurationViewModel
    
    let createBrewTapped: (String, Int, String) -> Void
    let amountOfSamplesChanged: (Int?) -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            List {
                configureSettingsSection()
                ForEach(viewModel.samplesArray.indices, id: \.self) { index in
                    configureSampleSection(with: index)
                }
            }
            configureActionButton()
        }
        .padding(.vertical, 32)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

// MARK: - Configure UI

extension BrewConfigurationView {
    func configureActionButton() -> some View {
        ActionButton(
            action: {
                createBrewTapped(
                    viewModel.cappingName,
                    viewModel.amountOfSamples ?? 1,
                    viewModel.comment
                )
            },
            content: {
                Text(viewModel.brewConfigurationButtonText)
            }
        )
            .padding(.horizontal, 64)
    }
    
    func configureSettingsSection() -> some View {
        let bindingAmountOfSamples = Binding<String>(
            get: { self.viewModel.amountOfSamples?.numberToString ?? "" },
            set: { self.viewModel.amountOfSamples = $0.stringToNumber }
        )
        
        return Section(header: Text("Settings")) {
            TextField(
                "cappingName",
                text: $viewModel.cappingName,
                prompt: Text("Capping Name")
            )
            
            Toggle("Is capping blind?", isOn: $viewModel.isBlind)
            
            Toggle("Is capping social?", isOn: $viewModel.isSocial)
            
            TextField(
                "amountOfSamples",
                text: bindingAmountOfSamples,
                prompt: Text("Amount of Samples")
            )
                .onChange(of: viewModel.amountOfSamples, perform: { newValue in
                    withAnimation {
                        amountOfSamplesChanged(newValue)
                    }
                })
                .keyboardType(.numberPad)
            
            
            TextField(
                "comment",
                text: $viewModel.comment,
                prompt: Text("Comment")
            )
        }
    }
    
    func configureSampleSection(with index: Int) -> some View {
        let bindingBlindNumber = Binding<String>(
            get: { viewModel.samplesArray[index].blindNumber.numberToString },
            set: { viewModel.samplesArray[index].blindNumber = $0.stringToNumber ?? 1 }
        )

        return Section(header: Text("Configure sample \(bindingBlindNumber.wrappedValue)")) {
            TextField(
                "blindNumber",
                text: bindingBlindNumber,
                prompt: Text(viewModel.blindNumberPlaceholder)
            )
                .keyboardType(.numberPad)

            TextField(
                "sampleName",
                text: $viewModel.samplesArray[index].name,
                prompt: Text(viewModel.namePlaceholder + bindingBlindNumber.wrappedValue)
            )

            TextField(
                "roastDate",
                text: $viewModel.samplesArray[index].roastDate,
                prompt: Text(viewModel.roastDatePlaceholder)
            )
        }
    }
}

struct BrewConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        BrewConfigurationView(
            viewModel: BrewConfigurationViewModel(),
            createBrewTapped: {_,_,_ in },
            amountOfSamplesChanged: { _ in }
        )
    }
}
