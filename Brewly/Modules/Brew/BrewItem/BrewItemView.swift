//
//  BrewItemView.swift
//  Brewly
//
//  Created by Anton Vlezko on 08.11.2021.
//

import SwiftUI

struct BrewItemView: View {
    @State private var aromaValue: Double = 0
    @State private var comment: String = ""
    @State var hidePlaceholder: Bool = false
    
    var body: some View {
        List {
            sectionBuilder(title: "Aroma")
            sectionBuilder(title: "Acidity")
            sectionBuilder(title: "Sweetness")
        }
    }
    
    func sectionBuilder(title: String) -> some View {
        Section {
            sliderView(title: "Intensity", value: "Strong")
            sliderView(title: "Quality", value: "Weak")
            commentView()
        } header: {
            Text(title)
        }
    }
    
    func commentView() -> some View {
        ZStack(alignment: .leading) {
            ZStack {
                TextEditor(text: $comment)
                    .onTapGesture {
                        hidePlaceholder = true
                    }
                Text(comment).opacity(0).padding(.all, 8)
            }
            Text("Comment")
                .opacity(hidePlaceholder ? 0 : 1)
                .foregroundColor(.gray)
                .onChange(of: comment) { newComment in
                    if newComment != "" {
                        hidePlaceholder = true
                    } else {
                        hidePlaceholder = false
                    }
                }
        }
    }
    
    func sliderView(title: String, value: String) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()

                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            
            Slider(value: $aromaValue,
                   in: 0...4)
            
        }
    }
    
}

struct BrewItemView_Previews: PreviewProvider {
    static var previews: some View {
        BrewItemView()
    }
}
