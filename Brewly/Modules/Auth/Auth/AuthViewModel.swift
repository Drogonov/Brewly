//
//  AuthViewModel.swift
//  Brewly
//
//  Created by Anton Vlezko on 17.11.2021.
//

import Foundation

struct AuthViewModel {
    let navigationTitle: String
    let option: AuthOption
    let buttonsArray: [AuthButtonViewModel]
    let authConfigButtonText: String
    let questionText: String
    let solutionText: String
}
