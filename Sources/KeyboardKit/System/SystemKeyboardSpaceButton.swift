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
 the provided `localeText`, then fades in `spaceText`.
 
 This view renders a `SystemKeyboardSpaceButtonContent` then
 applies a standard button style and action gestures to it.
 */
public struct SystemKeyboardSpaceButton: View {
    
    public init(
        localeText: String,
        spaceText: String,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance) {
        self.localeText = localeText
        self.spaceText = spaceText
        self.actionHandler = actionHandler
        self.appearance = appearance
    }
    
    private let localeText: String
    private let spaceText: String
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    
    private var action: KeyboardAction { .space }
    
    @State private var isPressed = false
    
    public var body: some View {
        SystemKeyboardSpaceButtonContent(localeText: localeText, spaceText: spaceText)
            .keyboardButtonStyle(
                for: action,
                appearance: appearance,
                isPressed: isPressed)
            .keyboardGestures(
                for: action,
                isPressed: $isPressed,
                actionHandler: actionHandler)
    }
}
