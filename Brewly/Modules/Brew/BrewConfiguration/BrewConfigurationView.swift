//
//  BrewConfigurationView.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import SwiftUI

struct BrewConfigurationView: View {
    @State private var cappingName: String = ""
    @State private var amountOfSamples: Int?
    @State private var isBlind: Bool = true
    @State private var isSocial: Bool = false
    @State private var comment: String = ""
    
    @Binding var samplesArray: [BrewConfigurationSampleModel]
    
    let brewConfigurationButtonText: String
    let createBrewTapped: (String, Int, String) -> Void
    let amountOfSamplesChanged: (Int?) -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            List {
                configureSettingsSection()
                
                ForEach(samplesArray, id: \.id) { sample in
                    configureSampleSection(with: sample)
                }
            }
            
            ActionButton(
                action: {
                    createBrewTapped(
                        cappingName,
                        amountOfSamples ?? 1,
                        comment
                    )
                },
                content: {
                    Text(brewConfigurationButtonText)
                }
            )
                .padding(.horizontal, 64)
        }
        .padding(.vertical, 32)
    }
}

// MARK: - Helper Functions

extension BrewConfigurationView {
    func configureSettingsSection() -> some View {
        let bindingAmountOfSamples = Binding<String>(
            get: { self.amountOfSamples?.numberToString ?? "" },
            set: { self.amountOfSamples = $0.stringToNumber }
        )
        
        return Section(header: Text("Settings")) {
            TextField(
                "cappingName",
                text: $cappingName,
                prompt: Text("Capping Name")
            )
            
            Toggle("Is capping blind?", isOn: $isBlind)
            
            Toggle("Is capping social?", isOn: $isSocial)
            
            TextField(
                "amountOfSamples",
                text: bindingAmountOfSamples,
                prompt: Text("Amount of Samples")
            )
                .onChange(of: amountOfSamples, perform: { newValue in
                    withAnimation {
                        amountOfSamplesChanged(newValue)
                    }
                })
                .keyboardType(.numberPad)
            
            
            TextField(
                "comment",
                text: $comment,
                prompt: Text("Comment")
            )
        }
    }
    
    func configureSampleSection(with sample: BrewConfigurationSampleModel) -> some View {
        @State var blindNumber = sample.blindNumber
        @State var sampleName = sample.name
        @State var sampleDate = sample.roastDate
        
        let bindingBlindNumber = Binding<String>(
            get: { blindNumber.numberToString },
            set: { blindNumber = $0.stringToNumber ?? 1 }
        )
        
        return Section(header: Text("Sample configure")) {
            TextField(
                "blindNumber",
                text: bindingBlindNumber,
                prompt: Text("Blind number")
            )
                .keyboardType(.numberPad)
            
            TextField(
                "cappingName",
                text: $sampleName,
                prompt: Text("Sample name")
            )
            
            TextField(
                "cappingName",
                text: $sampleDate,
                prompt: Text("Roast date")
            )
        }
    }
}

struct BrewConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        BrewConfigurationView(
            samplesArray: .constant([]),
            brewConfigurationButtonText: "Let's Brew!",
            createBrewTapped: {_,_,_ in },
            amountOfSamplesChanged: { _ in }
        )
    }
}
