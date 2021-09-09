//
//  SystemKeyboardButtonBody.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view represents the body of a standard system keyboard
 button, which represents the buttons in an iOS keyboard.
 */
public struct SystemKeyboardButtonBody: View {
    
    public init(style: SystemKeyboardButtonStyle) {
        self.style = style
    }
    
    private let style: SystemKeyboardButtonStyle
    
    public var body: some View {
        RoundedRectangle(cornerRadius: style.cornerRadius)
            .strokeBorder(style.border.color, lineWidth: style.border.size)
            .background(style.backgroundColor)
            .cornerRadius(style.cornerRadius)
            .overlay(SystemKeyboardButtonShadow(style: style))
    }
}

struct SystemKeyboardButtonBody_Previews: PreviewProvider {
    
    static func body(for action: KeyboardAction) -> SystemKeyboardButtonBody {
        let style = SystemKeyboardButtonStyle(
            backgroundColor: .yellow,
            foregroundColor: .white,
            font: .body,
            cornerRadius: 20,
            border: SystemKeyboardButtonBorderStyle(color: .red, size: 3),
            shadow: SystemKeyboardButtonShadowStyle(color: .blue, size: 4)
        )
        return SystemKeyboardButtonBody(style: style)
    }
    
    static var previews: some View {
        VStack {
            body(for: .character("a"))
            body(for: .character("A"))
            body(for: .backspace)
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
        .keyboardPreview()
    }
}
