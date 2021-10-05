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
 will apply the correct frames and paddings, to mitigate any
 dead tap areas that would exist if a system keyboard placed
 its buttons with margins between the buttons and rows.
 */
public struct SystemKeyboardButtonRowItem<Content: View>: View {
    
    /**
     Create a system keyboard button row item.
     
     - Parameters:
       - content: The content view to use within the item.
       - item: The layout item to use within the item.
       - keyboardWidth: The total width of the keyboard.
       - inputWidth: The input width within the keyboard.
       - appearance: The appearance to apply to the item.
       - actionHandler: The button style to apply.
     */
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
            .systemKeyboardButtonStyle(buttonStyle)
            .padding(item.insets)
            .background(Color.clearInteractable)
            .keyboardGestures(
                for: item.action,
                context: context,
                actionHandler: actionHandler,
                isPressed: $isPressed)
    }
}

private extension SystemKeyboardButtonRowItem {
    
    var buttonStyle: SystemKeyboardButtonStyle {
        appearance.systemKeyboardButtonStyle(for: item.action, isPressed: isPressed)
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
