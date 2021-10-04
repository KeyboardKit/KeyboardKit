//
//  SystemKeyboardButtonText.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics text in a system keyboard button, which is
 line limited to 1 and vertically offset if the button is an
 input button and the text is lowercased.
 */
public struct SystemKeyboardButtonText: View {
    
    /**
     Create a system keyboard button text view.
     
     - Parameters:
       - text: The text to display.
       - action: The action bound to the button.
     */
    public init(
        text: String,
        action: KeyboardAction) {
        self.text = text
        self.action = action
    }
    
    private let text: String
    private let action: KeyboardAction
    
    public var body: some View {
        Text(text)
            .lineLimit(1)
            .offset(y: useNegativeOffset ? -2 : 0)
    }
}

private extension SystemKeyboardButtonText {
    
    var useNegativeOffset: Bool {
        action.isInputAction && text.isLowercased
    }
}

struct SystemKeyboardButtonText_Previews: PreviewProvider {
    
    static var previews: some View {
        HStack {
            SystemKeyboardButtonText(text: "PasCal", action: .space)
            SystemKeyboardButtonText(text: "UPPER", action: .space)
            SystemKeyboardButtonText(text: "lower", action: .space)
            SystemKeyboardButtonText(text: "non-input", action: .backspace)
        }
    }
}
