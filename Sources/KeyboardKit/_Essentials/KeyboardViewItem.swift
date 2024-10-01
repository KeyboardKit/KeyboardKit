//
//  KeyboardViewItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view renders button item for a ``KeyboardView``.
/// 
/// The reason why the ``KeyboardView`` doesn't just use the
/// ``Keyboard/Button`` view, is that this view applies more
/// insets and configurations to the content.
///
/// `TODO` KeyboardKit 9.0 should change ``KeyboardView`` to
/// not use this view, but rather uses a ``Keyboard/Button``
/// with the proper styles, insets, etc.
public struct KeyboardViewItem<Content: View>: View {

    /// Create a keyboard view item.
    ///
    /// - Parameters:
    ///   - item: The layout item to use within the item.
    ///   - actionHandler: The button style to apply.
    ///   - repeatTimer: The repeat gesture timer to use, if any.
    ///   - styleService: The style service to use.
    ///   - keyboardContext: The keyboard context to which the item should apply.,
    ///   - calloutContext: The callout context to affect, if any.
    ///   - keyboardWidth: The total width of the keyboard.
    ///   - inputWidth: The input width within the keyboard.
    ///   - isNextProbability: The probability (0-1) that the button will be tapped next.
    ///   - content: The content view to use within the item.
    init(
        item: KeyboardLayout.Item,
        actionHandler: KeyboardActionHandler,
        repeatTimer: GestureButtonTimer? = nil,
        styleService: KeyboardStyleService,
        keyboardContext: KeyboardContext,
        calloutContext: CalloutContext?,
        keyboardWidth: CGFloat,
        inputWidth: CGFloat,
        isNextProbability: Double = 0,
        content: Content
    ) {
        self.item = item
        self.actionHandler = actionHandler
        self.repeatTimer = repeatTimer
        self.styleService = styleService
        self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        self.calloutContext = calloutContext
        self.keyboardWidth = keyboardWidth
        self.inputWidth = inputWidth
        self.isNextProbability = isNextProbability
        self.content = content
    }

    private let item: KeyboardLayout.Item
    private let actionHandler: KeyboardActionHandler
    private let repeatTimer: GestureButtonTimer?
    private let styleService: KeyboardStyleService
    private let calloutContext: CalloutContext?
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let isNextProbability: Double
    private let content: Content
    
    @ObservedObject
    private var keyboardContext: KeyboardContext
    
    @State
    private var isPressed = false
    
    public var body: some View {
        ZStack(alignment: item.alignment) {
            Color.clearInteractable
            content
        }
        .opacity(contentOpacity)
        .animation(.default, value: keyboardContext.isSpaceDragGestureActive)
        .keyboardLayoutItemSize(
            for: item,
            rowWidth: keyboardWidth,
            inputWidth: inputWidth
        )
        .keyboardButton(
            for: item.action,
            style: buttonStyle,
            actionHandler: actionHandler,
            repeatTimer: repeatTimer,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            additionalTapArea: isNextProbability * 5,
            edgeInsets: item.edgeInsets,
            isPressed: $isPressed
        )
    }
    
    private var contentOpacity: Double {
        keyboardContext.isSpaceDragGestureActive ? 0 : 1
    }
    
    private var buttonStyle: Keyboard.ButtonStyle {
        item.action.isSpacer ? .spacer : styleService.buttonStyle(for: item.action, isPressed: isPressed)
    }
}

#Preview {
    
    KeyboardViewItem(
        item: .init(
            action: .backspace,
            size: .init(width: .points(100), height: 100),
            alignment: .bottomLeading,
            edgeInsets: .init(horizontal: 10, vertical: 10)
        ),
        actionHandler: .preview,
        styleService: .preview,
        keyboardContext: .preview,
        calloutContext: .preview,
        keyboardWidth: 100,
        inputWidth: 100,
        content: Text("HEJ")
    )
    .background(Color.red)
}
