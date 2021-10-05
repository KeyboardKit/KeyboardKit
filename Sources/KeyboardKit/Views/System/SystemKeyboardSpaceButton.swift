//
//  SystemKeyboardSpaceButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics the system space button, which starts with
 displaying the `localeText`, then fading to the `spaceText`.
 
 If you don't provide a `localeText`, this view will use the
 context's current locale. If you don't provide a `spaceText`,
 it will use the localized `KKL10n.space` text.
 
 Provide empty strings if you don't want to display any text.
 
 This view creates a `SystemKeyboardSpaceButtonContent` then
 applies a keyboard button style and gestures to it.
 */
public struct SystemKeyboardSpaceButton: View {
    
    /**
     Create a system keyboard space button.
     
     - Parameters:
       - localeText: The name of the current locale, if any.
       - spaceText: The localized name for "space", if any.
       - actionHandler: The action handler to use.
       - appearance: The appearance to apply to the button.
     */
    public init(
        localeText: String,
        spaceText: String,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance) {
        self.content = SystemKeyboardSpaceButtonContent(
            localeText: localeText,
            spaceText: spaceText)
        self.actionHandler = actionHandler
        self.appearance = appearance
    }
    
    private var content: SystemKeyboardSpaceButtonContent
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private var action: KeyboardAction { .space }
    
    @State private var isPressed = false
    
    @EnvironmentObject private var context: KeyboardContext
    
    public var body: some View {
        content
            .systemKeyboardButtonStyle(
                appearance.systemKeyboardButtonStyle(for: action, isPressed: isPressed))
            .keyboardGestures(
                for: action,
                context: context,
                actionHandler: actionHandler,
                isPressed: $isPressed)
    }
}

struct SystemKeyboardSpaceButton_Previews: PreviewProvider {
    
    static var previews: some View {
        SystemKeyboardSpaceButton(
            localeText: "foo",
            spaceText: "bar",
            actionHandler: .preview,
            appearance: PreviewKeyboardAppearance())
            .keyboardPreview()
    }
}
