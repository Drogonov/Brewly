//
//  ActionButton.swift
//  Brewly
//
//  Created by Anton Vlezko on 16.11.2021.
//

import SwiftUI

struct ActionButton<Content: View>: View {
    
    // MARK: - Properties
    
    var action: () -> Void
    var content: Content
    
    // Properties not required to initialize
    let foregroundColor: Color
    let backgroundColor: Color
    
    init(
        foregroundColor: Color = Color.actionButtonTextColor,
        backgroundColor: Color = Color.actionButtonBackgroundColor,
        action: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.action = action
        self.content = content()
    }
    
    // MARK: - Construction
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                content
            }
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(8)
        }
    }
}

// MARK: - ActionButton_Previews

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(
            action: {},
            content: {
                Text("Button")
            }
        )
    }
}
