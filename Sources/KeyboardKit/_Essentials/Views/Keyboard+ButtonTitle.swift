//
//  Keyboard+ButtonTitle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-04.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This view renders keyboard a button title text.
    ///
    /// The text is limited to a single line with a vertical
    /// offset for input actions with lowercased text.
    struct ButtonTitle: View {
        
        /// Create a keyboard button title view.
        ///
        /// - Parameters:
        ///   - text: The text to display.
        ///   - action: The action bound to the button.
        public init(
            text: String,
            action: KeyboardAction
        ) {
            self.text = text
            self.isInputAction = action.isInputAction
        }
        
        private let text: String
        private let isInputAction: Bool
        
        public var body: some View {
            Text(text)
                .lineLimit(1)
                .offset(y: useNegativeOffset ? -2 : 0)
                .minimumScaleFactor(0.8)
        }
    }
}

private extension Keyboard.ButtonTitle {
    
    var useNegativeOffset: Bool {
        isInputAction && text.isLowercasedWithUppercaseVariant
    }
}

#Preview {
    
    HStack {
        Keyboard.ButtonTitle(text: "PasCal", action: .space)
        Keyboard.ButtonTitle(text: "UPPER", action: .space)
        Keyboard.ButtonTitle(text: "lower", action: .space)
        Keyboard.ButtonTitle(text: "non-input", action: .backspace)
    }
}
