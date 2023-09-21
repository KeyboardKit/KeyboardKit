//
//  SystemKeyboardItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view renders button item for a ``SystemKeyboard``.
 */
public struct SystemKeyboardItem<Content: View>: View {
    
    /**
     Create a system keyboard button row item.
     
     - Parameters:
       - item: The layout item to use within the item.
       - actionHandler: The button style to apply.
       - styleProvider: The style provider to use.
       - keyboardContext: The keyboard context to which the item should apply.,
       - calloutContext: The callout context to affect, if any.
       - keyboardWidth: The total width of the keyboard.
       - inputWidth: The input width within the keyboard.
       - content: The content view to use within the item.
     */
    init(
        item: KeyboardLayout.Item,
        actionHandler: KeyboardActionHandler,
        styleProvider: KeyboardStyleProvider,
        keyboardContext: KeyboardContext,
        calloutContext: CalloutContext?,
        keyboardWidth: CGFloat,
        inputWidth: CGFloat,
        content: Content
    ) {
        self.item = item
        self.actionHandler = actionHandler
        self.styleProvider = styleProvider
        self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        self.calloutContext = calloutContext
        self.keyboardWidth = keyboardWidth
        self.inputWidth = inputWidth
        self.content = content
    }
    
    private let item: KeyboardLayout.Item
    private let actionHandler: KeyboardActionHandler
    private let styleProvider: KeyboardStyleProvider
    private let calloutContext: CalloutContext?
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let content: Content
    
    @ObservedObject
    private var keyboardContext: KeyboardContext
    
    @State
    private var isPressed = false
    
    public var body: some View {
        content
            .keyboardLayoutItemSize(
                for: item,
                rowWidth: keyboardWidth,
                inputWidth: inputWidth)
            .keyboardButton(
                for: item.action,
                style: buttonStyle,
                actionHandler: actionHandler,
                keyboardContext: keyboardContext,
                calloutContext: calloutContext,
                edgeInsets: item.edgeInsets,
                isPressed: $isPressed
            )
    }
    
    private var buttonStyle: KeyboardStyle.Button {
        item.action.isSpacer ? .spacer : styleProvider.buttonStyle(for: item.action, isPressed: isPressed)
    }
}
