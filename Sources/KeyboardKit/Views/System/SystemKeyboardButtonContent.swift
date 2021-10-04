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
 
 If provided, the optional `text` or `image` is used instead
 of the standard action content.
 */
public struct SystemKeyboardButtonContent: View {
    
    /**
     Create a system keyboard button content view.
     
     - Parameters:
       - action: The action for which to generate content.
       - appearance: The appearance to apply to the content.
       - text: An explicit text, to replace the action content.
       - image: An explicit image, to replace the action content.
     */
    public init(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        text: String? = nil,
        image: Image? = nil) {
        self.appearance = appearance
        self.action = action
        self.text = text
        self.image = image
    }
    
    private let appearance: KeyboardAppearance
    private let action: KeyboardAction
    private let image: Image?
    private let text: String?
    
    public var body: some View {
        if action == .nextKeyboard {
            NextKeyboardButton()
        } else if let image = buttonImage {
            image
        } else if let text = buttonText {
            SystemKeyboardButtonText(
                text: text,
                isInputAction: action.isInputAction)
        } else {
            Text("")
        }
    }
}

private extension SystemKeyboardButtonContent {
    
    var buttonImage: Image? {
        image ?? appearance.buttonImage(for: action)
    }
    
    var buttonText: String? {
        text ?? appearance.buttonText(for: action)
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
