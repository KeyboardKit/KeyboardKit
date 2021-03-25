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
    
    public init(
        localeText: String? = nil,
        spaceText: String? = nil,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance) {
        self.content = SystemKeyboardSpaceButtonContent(localeText: localeText, spaceText: "")
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.content = SystemKeyboardSpaceButtonContent(localeText: localeText , spaceText: spaceText ?? KKL10n.space.text(for: context))
    }
    
    private var content: SystemKeyboardSpaceButtonContent
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private var action: KeyboardAction { .space }
    
    @State private var isPressed = false
    
    @EnvironmentObject private var context: KeyboardContext
    
    public var body: some View {
        content
            .keyboardButtonStyle(
                for: action,
                appearance: appearance,
                isPressed: isPressed)
            .keyboardGestures(
                for: action,
                context: context,
                isPressed: $isPressed,
                actionHandler: actionHandler)
    }
}

struct SystemKeyboardSpaceButton_Previews: PreviewProvider {
    
    static let actionHandler = PreviewKeyboardActionHandler()
    static let appearance = PreviewKeyboardAppearance()
    
    static var previews: some View {
        SystemKeyboardSpaceButton(actionHandler: actionHandler, appearance: appearance)
            .environmentObject(KeyboardContext.preview)
    }
}
