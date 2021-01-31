//
//  SystemKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics the buttons that are used in an iOS system
 keyboard. It wraps a `SystemKeyboardButtonContent` view and
 applies a standard button style and action gestures to it.
 */
public struct SystemKeyboardButton: View {
    
    public init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        text: String? = nil,
        image: Image? = nil) {
        self.action = action
        self.actionHandler = actionHandler
        self.text = text
        self.image = image
    }
    
    private let action: KeyboardAction
    private let actionHandler: KeyboardActionHandler
    private let image: Image?
    private let text: String?
    
    @EnvironmentObject var context: ObservableKeyboardContext
    
    @ViewBuilder
    public var body: some View {
        SystemKeyboardButtonContent(action: action, text: text, image: image)
            .standardButtonStyle(for: action, context: context)
            .keyboardGestures(for: action, actionHandler: actionHandler)
    }
}
