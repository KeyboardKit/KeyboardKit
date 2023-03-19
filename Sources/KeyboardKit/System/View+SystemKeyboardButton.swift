//
//  View+SystemKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-24.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Apply a keyboard button style to the view.

     - Parameters:
       - style: The style to apply.
       - isPressed: Whether or not the button is pressed, by default `false`.
     */
    func systemKeyboardButtonStyle(
        _ style: KeyboardButtonStyle,
        isPressed: Bool = false
    ) -> some View {
        self.background(SystemKeyboardButtonBody(style: style))
            .overlay(isPressed ? style.pressedOverlayColor : Color.clear)
            .foregroundColor(style.foregroundColor)
            .font(style.font)
    }
}

struct View_Button_Previews: PreviewProvider {
    
    static func button<Content: View>(
        for content: Content,
        style: KeyboardButtonStyle
    ) -> some View {
        content
            .padding()
            .systemKeyboardButtonStyle(style, isPressed: false)
    }
    
    static var previews: some View {
        VStack(spacing: 20) {
            button(for: Text("a"), style: .preview1)
            button(for: Text("A"), style: .preview2)
            button(for: Image.keyboardGlobe, style: .preview1)
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
    }
}
