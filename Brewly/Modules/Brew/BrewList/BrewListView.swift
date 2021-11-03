//
//  BrewListView.swift
//  Brewly
//
//  Created by Anton Vlezko on 02.11.2021.
//

import SwiftUI

struct BrewListView: View {
    var body: some View {
        List {
            cellBuilder()
            cellBuilder()
            cellBuilder()
        }
    }
    
    func cellBuilder() -> some View {
        Button(action: {
            
        }, label: {
            HStack {
                VStack(alignment: .leading) {
                    Text("Sample 1")
                        .font(.title)
                        .foregroundColor(.primary)
                    Text("roasted 01.01.2021")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        })
    }
}

struct BrewListView_Previews: PreviewProvider {
    static var previews: some View {
        BrewListView()
    }
}
