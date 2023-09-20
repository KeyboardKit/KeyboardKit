//
//  KeyboardButton+Key.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardButton {
    
    /**
     This view renders the key shape of a keyboard button.
     
     It applies the button shape, corner radius, shadow, etc.
     */
    struct Key: View {
        
        /**
         Create a keyboard button body view.
         
         - Parameters:
           - style: The button style to apply.
           - isPressed: Whether or not the button is pressed, by default `false`.
         */
        public init(
            style: Style,
            isPressed: Bool = false
        ) {
            self.style = style
            self.isPressed = isPressed
        }
        
        public typealias Style = KeyboardStyle.Button
        
        private let style: Style
        private let isPressed: Bool
        
        public var body: some View {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(borderColor, lineWidth: borderLineWidth)
                .background(backgroundColor)
                .overlay(isPressed ? style.pressedOverlayColor : .clear)
                .cornerRadius(cornerRadius)
                .overlay(Shadow(style: style))
        }
    }
}

public extension KeyboardButton.Key {

    var backgroundColor: Color { style.backgroundColor ?? .clear }

    var borderColor: Color { style.border?.color ?? .clear }

    var borderLineWidth: CGFloat { style.border?.size ?? 0 }

    var cornerRadius: CGFloat { style.cornerRadius ?? 0 }
}

struct KeyboardButton_Body_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            KeyboardButton.Key(style: .preview1)
            KeyboardButton.Key(style: .preview2)
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
    }
}
