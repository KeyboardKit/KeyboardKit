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
        actionHandler: KeyboardActionHandler) {
        self.localeText = localeText
        self.spaceText = spaceText
        self.actionHandler = actionHandler
    }
    
    private let localeText: String
    private let spaceText: String
    private let actionHandler: KeyboardActionHandler
    private var action: KeyboardAction { .space }
    
    @EnvironmentObject private var context: ObservableKeyboardContext
    @EnvironmentObject private var inputCalloutContext: InputCalloutContext
    @EnvironmentObject private var secondaryInputCalloutContext: SecondaryInputCalloutContext
    
    public var body: some View {
        SystemKeyboardSpaceButtonContent(localeText: localeText, spaceText: spaceText)
            .standardButtonStyle(for: action, context: context)
            .keyboardGestures(
                for: action,
                actionHandler: actionHandler,
                inputCalloutContext: inputCalloutContext,
                secondaryInputCalloutContext: secondaryInputCalloutContext)
    }
}
