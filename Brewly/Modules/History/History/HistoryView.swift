//
//  HistoryView.swift
//  Brewly
//
//  Created by Anton Vlezko on 29.10.2021.
//

import SwiftUI

struct HistoryView: View {
    
    var detailButtonTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Button {
                detailButtonTapped()
            } label: {
                Text("К деталям")
            }
            Spacer()
        }
    }
}

