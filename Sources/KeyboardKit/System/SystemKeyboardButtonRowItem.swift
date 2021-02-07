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
        content: Content,
        item: KeyboardLayoutItem,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler) {
        self.content = content
        self.item = item
        self.appearance = appearance
        self.actionHandler = actionHandler
    }
    
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let content: Content
    private let item: KeyboardLayoutItem
    
    @EnvironmentObject private var context: ObservableKeyboardContext
    
    public var body: some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: item.size.height - item.insets.top - item.insets.bottom)
            .applyWidth(for: item.action)
            .keyboardButtonStyle(for: item.action, appearance: appearance)
            .padding(item.insets)
            .frame(height: item.size.height)
            .background(Color.clearInteractable)
            .keyboardGestures(for: item.action, actionHandler: actionHandler)
    }
}

private extension View {
    
    @ViewBuilder
    func applyWidth(for action: KeyboardAction) -> some View { self }
}
