//
//  KeyboardButtonText.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-04.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view renders keyboard button text content.
 
 This text is line limited to 1 and has a vertical offset if
 the button is an input button and the text is lowercased.
 */
public struct KeyboardButtonText: View {
    
    /**
     Create a system keyboard button text view.
     
     - Parameters:
       - text: The text to display.
       - action: The action bound to the button.
     */
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
    }
}

private extension KeyboardButtonText {
    
    var useNegativeOffset: Bool {
        isInputAction && text.isLowercased
    }
}

struct KeyboardButtonText_Previews: PreviewProvider {
    
    static var previews: some View {
        HStack {
            KeyboardButtonText(text: "PasCal", action: .space)
            KeyboardButtonText(text: "UPPER", action: .space)
            KeyboardButtonText(text: "lower", action: .space)
            KeyboardButtonText(text: "non-input", action: .backspace)
        }
    }
}
