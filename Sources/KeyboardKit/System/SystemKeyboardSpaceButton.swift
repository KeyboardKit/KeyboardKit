//
//  SystemKeyboardSpaceButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics the system space button, which starts with
 the provided `localeText`, then fades in `spaceText`.
 
 This view renders a `SystemKeyboardSpaceButtonContent` then
 applies a standard button style and action gestures to it.
 */
public struct SystemKeyboardSpaceButton: View {
    
    public init(localeText: String, spaceText: String) {
        self.localeText = localeText
        self.spaceText = spaceText
    }
    
    private let localeText: String
    private let spaceText: String
    private var action: KeyboardAction { .space }
    
    @EnvironmentObject var context: ObservableKeyboardContext
    
    public var body: some View {
        SystemKeyboardSpaceButtonContent(localeText: localeText, spaceText: spaceText)
            .standardButtonStyle(for: action, context: context)
            .keyboardGestures(for: action, actionHandler: context.actionHandler)
    }
}
