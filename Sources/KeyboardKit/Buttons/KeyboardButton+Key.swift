//
//  KeyboardButton+Key.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardButton {
    
    /// This view mimics a native keyboard button shape.
    ///
    /// It applies a button shape, corner radius, shadow etc.
    ///
    /// You can style this component using the view modifier
    /// ``keyboardButtonStyle(_:)``.
    struct Key: View {
        
        /// Create a keyboard button body.
        ///
        /// - Parameters:
        ///   - isPressed: Whether or not the button is pressed, by default `false`.
        public init(
            isPressed: Bool = false
        ) {
            self.initStyle = nil
            self.isPressed = isPressed
        }
        
        @available(*, deprecated, message: "Style this view with .keyboardButtonStyle instead.")
        public init(
            style: KeyboardButton.ButtonStyle,
            isPressed: Bool = false
        ) {
            self.initStyle = style
            self.isPressed = isPressed
        }
        
        private let isPressed: Bool
        
        @Environment(\.keyboardButtonStyle)
        private var envStyle
        
        public var body: some View {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(borderColor, lineWidth: borderLineWidth)
                .background(style.background)
                .background(backgroundColor)
                .overlay(isPressed ? style.pressedOverlayColor : .clear)
                .cornerRadius(cornerRadius)
                .overlay(KeyboardButton.Shadow())
                .keyboardButtonStyle(style)  // Not needed in 9.0
        }
        
        // MARK: - Deprecated
        
        private typealias Style = KeyboardButton.ButtonStyle
        private let initStyle: Style?
        private var style: Style { initStyle ?? envStyle }
    }
}

public extension KeyboardButton.Key {

    var backgroundColor: Color { style.backgroundColor ?? .clear }
    var borderColor: Color { style.border?.color ?? .clear }
    var borderLineWidth: CGFloat { style.border?.size ?? 0 }
    var cornerRadius: CGFloat { style.cornerRadius ?? 0 }
}

#Preview {
    
    VStack {
        KeyboardButton.Key()
            .keyboardButtonStyle(.preview1)
        KeyboardButton.Key()
            .keyboardButtonStyle(.preview2)
        KeyboardButton.Key()
            .keyboardButtonStyle(.previewImage)
    }
    .padding()
}
