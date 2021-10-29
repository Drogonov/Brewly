//
//  DetailHistoryView.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import SwiftUI

struct DetailHistoryView: View {
    
    var loginButtonTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Button {
                loginButtonTapped()
            } label: {
                Text("К логину")
            }
            Spacer()
        }
    }
}
