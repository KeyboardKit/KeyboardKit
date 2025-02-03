//
//  Keyboard+ButtonKey.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This view mimics a native keyboard button key shape.
    ///
    /// The view will render the button shape, corner radius,
    /// shadow etc. and act on an injected pressed state.
    ///
    /// You can style this component with the style modifier
    /// ``keyboardButtonStyle(_:)``.
    struct ButtonKey: View {
        
        /// Create a keyboard button key.
        public init() {}

        
        @Environment(\.keyboardButtonStyle)
        private var style

        public var body: some View {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(borderColor, lineWidth: borderLineWidth)
                .background(style.background)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
                .overlay(Keyboard.ButtonShadow())
        }
    }
}

public extension Keyboard.ButtonKey {

    var backgroundColor: Color { style.backgroundColor ?? .clear }
    var borderColor: Color { style.border?.color ?? .clear }
    var borderLineWidth: CGFloat { style.border?.size ?? 0 }
    var cornerRadius: CGFloat { style.cornerRadius ?? 0 }
}

#Preview {
    
    VStack {
        Keyboard.ButtonKey()
            .keyboardButtonStyle(.preview1)
        Keyboard.ButtonKey()
            .keyboardButtonStyle(.preview2)
        Keyboard.ButtonKey()
            .keyboardButtonStyle(.previewImage)
    }
    .padding()
}
