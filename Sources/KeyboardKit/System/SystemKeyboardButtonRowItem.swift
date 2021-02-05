//
//  SystemKeyboardButtonRowItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view is meant to be used within a `SystemKeyboard` and
 will apply the correct frames and paddings to make the view
 behave well within an automatically generated keyboard view.
 
 This view wraps a `SystemKeyboardButtonContent` and adjusts
 it to be used within a keyboard row. This involves applying
 height and paddings and new gestures in a way that make the
 buttons seem separated while actually sticking together.
 */
public struct SystemKeyboardButtonRowItem<Content: View>: View {
    
    public init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        buttonContent: Content,
        layout: KeyboardLayout) {
        self.action = action
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.buttonContent = buttonContent
        self.layout = layout
    }
    
    private let action: KeyboardAction
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let buttonContent: Content
    private let layout: KeyboardLayout
    
    @EnvironmentObject private var context: ObservableKeyboardContext
    
    public var body: some View {
        buttonContent
            .frame(maxWidth: .infinity)
            .frame(height: layout.buttonHeight - layout.buttonInsets.top - layout.buttonInsets.bottom)
            .applyWidth(for: action)
            .keyboardButtonStyle(for: action, appearance: appearance)
            .padding(layout.buttonInsets)
            .frame(height: layout.buttonHeight)
            .background(Color.clearInteractable)
            .keyboardGestures(for: action, actionHandler: actionHandler)
    }
}

private extension View {
    
    @ViewBuilder
    func applyWidth(for action: KeyboardAction) -> some View { self }
}
