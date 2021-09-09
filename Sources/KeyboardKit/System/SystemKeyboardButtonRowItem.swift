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
        keyboardWidth: CGFloat,
        inputWidth: CGFloat,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler) {
        self.content = content
        self.item = item
        self.keyboardWidth = keyboardWidth
        self.inputWidth = inputWidth
        self.appearance = appearance
        self.actionHandler = actionHandler
    }
    
    private let content: Content
    private let item: KeyboardLayoutItem
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let appearance: KeyboardAppearance
    private let actionHandler: KeyboardActionHandler
    
    @State private var isPressed = false
    
    @EnvironmentObject private var context: KeyboardContext
    
    public var body: some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: item.size.height - item.insets.top - item.insets.bottom)
            .rowItemWidth(for: item, totalWidth: keyboardWidth, referenceWidth: inputWidth)
            .systemKeyboardButtonStyle(
                for: item.action,
                appearance: appearance,
                isPressed: isPressed)
            .padding(item.insets)
            .background(Color.clearInteractable)
            .keyboardGestures(
                for: item.action,
                context: context,
                isPressed: $isPressed,
                actionHandler: actionHandler)
    }
}

public extension View {
    
    /**
     Apply a certain layout width to the view, in a way that
     works with the rot item composition above.
     */
    @ViewBuilder
    func rowItemWidth(for item: KeyboardLayoutItem, totalWidth: CGFloat, referenceWidth: CGFloat) -> some View {
        let insets = item.insets.leading + item.insets.trailing
        switch item.size.width {
        case .available: self.frame(maxWidth: .infinity)
        case .input: self.frame(width: referenceWidth - insets)
        case .inputPercentage(let percent): self.frame(width: percent * referenceWidth - insets)
        case .percentage(let percent): self.frame(width: percent * totalWidth - insets)
        case .points(let points): self.frame(width: points - insets)
        }
    }
}
