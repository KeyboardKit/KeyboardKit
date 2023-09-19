//
//  KeyboardButton+Title.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-04.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardButton {
    
    /**
     This view renders keyboard button text content.
     
     The text is limited to one line, with a vertical offset
     for input actions with lowercased text.
     */
    struct Title: View {
        
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
}

private extension KeyboardButton.Title {
    
    var useNegativeOffset: Bool {
        isInputAction && text.isLowercased
    }
}

struct KeyboardButton_Title_Previews: PreviewProvider {
    
    static var previews: some View {
        HStack {
            KeyboardButton.Title(text: "PasCal", action: .space)
            KeyboardButton.Title(text: "UPPER", action: .space)
            KeyboardButton.Title(text: "lower", action: .space)
            KeyboardButton.Title(text: "non-input", action: .backspace)
        }
    }
}
