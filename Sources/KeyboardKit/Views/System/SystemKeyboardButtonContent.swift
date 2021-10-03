//
//  SystemKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view resolves the correct content for a certain action,
 which will result in either a text or image or nothing.
 
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
        self.style = appearance.systemKeyboardButtonStyle(for: action, isPressed: false)
        self.action = action
        self.text = text
        self.image = image
    }
    
    private let appearance: KeyboardAppearance
    private let style: SystemKeyboardButtonStyle
    private let action: KeyboardAction
    private let image: Image?
    private let text: String?
    
    @EnvironmentObject private var context: KeyboardContext
    
    @ViewBuilder
    public var body: some View {
        if action == .nextKeyboard {
            NextKeyboardButton()
        } else if let image = buttonImage {
            image
        } else if let text = buttonText {
            textView(for: text)
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
    
    func textView(for text: String) -> some View {
        Text(text)
            .lineLimit(1)
            .offset(y: action.isInputAction && text.isLowercased ? -2 : 0)
    }
}

struct SystemKeyboardButtonContent_Previews: PreviewProvider {
    
    static var previews: some View {
        SystemKeyboardButtonContent(
            action: .backspace,
            appearance: .preview)
            .keyboardPreview()
    }
}
