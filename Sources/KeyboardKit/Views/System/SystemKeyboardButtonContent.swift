//
//  SystemKeyboardButtonContent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view resolves the correct content for a certain action,
 which will result in either a text or image, or nothing. It
 also sets up line limits, vertical offsets etc.
 */
public struct SystemKeyboardButtonContent: View {
    
    /**
     Create a system keyboard button content view.
     
     - Parameters:
       - action: The action for which to generate content.
       - appearance: The appearance to apply to the content.
     */
    public init(
        action: KeyboardAction,
        appearance: KeyboardAppearance) {
        self.appearance = appearance
        self.action = action
    }
    
    private let appearance: KeyboardAppearance
    private let action: KeyboardAction
    
    public var body: some View {
        if action == .nextKeyboard {
            NextKeyboardButton()
        } else if let image = buttonImage {
            image
        } else if let text = buttonText {
            SystemKeyboardButtonText(
                text: text,
                action: action)
        } else {
            Text("")
        }
    }
}

private extension SystemKeyboardButtonContent {
    
    var buttonImage: Image? {
        appearance.buttonImage(for: action)
    }
    
    var buttonText: String? {
        appearance.buttonText(for: action)
    }
}

struct SystemKeyboardButtonContent_Previews: PreviewProvider {
    
    static func preview(for action: KeyboardAction) -> some View {
        SystemKeyboardButtonContent(
            action: action,
            appearance: .preview)
    }
    
    static var previews: some View {
        HStack {
            preview(for: .backspace)
            preview(for: .character("PascalCased"))
            preview(for: .character("lowercased"))
        }
    }
}
