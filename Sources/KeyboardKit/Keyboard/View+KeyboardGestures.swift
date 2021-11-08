//
//  View+KeyboardGestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-21.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    typealias KeyboardGestureAction = () -> Void
    typealias KeyboardDragGestureAction = (_ startLocation: CGPoint, _ location: CGPoint) -> Void
    
    /**
     Apply keyboard-specific gestures to the view, using the
     provided `action`, `context` and `actionHandler`.
     
     If you provide an optional `KeyboardContext` the action
     can be provided with even more contextual actions.
     */
    @ViewBuilder
    func keyboardGestures(
        for action: KeyboardAction,
        context: KeyboardContext,
        actionHandler: KeyboardActionHandler,
        isPressed: Binding<Bool> = .constant(false)
    ) -> some View {
        switch action {
        case .nextKeyboard: self
        case .nextLocale: self
            .withKeyboardGestures(for: action, isPressed: isPressed, actionHandler: actionHandler)
            .withLocaleContextMenu(for: context)
        default: self
            .withKeyboardGestures(for: action, isPressed: isPressed, actionHandler: actionHandler)
        }
    }
    
    /**
     Apply keyboard-specific gestures to the view, using the
     provided action blocks.
     
     - Parameters:
       - action: The keyboard action to trigger.
       - isPressed: Whether or not the button is pressed.
       - tapAction: The action to trigger when the button is released within its bounds.
       - doubleTapAction: The action to trigger when the button is double tapped.
       - longPressAction: The action to trigger when the button is long pressed.
       - pressAction: The action to trigger when the button is pressed.
       - releaseAction: The action to trigger when the button is released, regardless of where the gesture ends.
       - repeatAction: The action to trigger when the button is pressed and held.
       - dragAction: The action to trigger when the button is dragged.
     */
    func keyboardGestures(
        action: KeyboardAction? = nil,
        isPressed: Binding<Bool> = .constant(false),
        tapAction: KeyboardGestureAction? = nil,
        doubleTapAction: KeyboardGestureAction? = nil,
        longPressAction: KeyboardGestureAction? = nil,
        pressAction: KeyboardGestureAction? = nil,
        releaseAction: KeyboardGestureAction? = nil,
        repeatAction: KeyboardGestureAction? = nil,
        dragAction: KeyboardDragGestureAction? = nil) -> some View {
        KeyboardGestures(
            view: self,
            action: action,
            isPressed: isPressed,
            tapAction: tapAction,
            doubleTapAction: doubleTapAction,
            longPressAction: longPressAction,
            pressAction: pressAction,
            releaseAction: releaseAction,
            repeatAction: repeatAction,
            dragAction: dragAction)
    }
}

private extension View {
    
    func withKeyboardGestures(
        for action: KeyboardAction,
        isPressed: Binding<Bool> = .constant(false),
        actionHandler: KeyboardActionHandler) -> some View {
        self.keyboardGestures(
            action: action,
            isPressed: isPressed,
            tapAction: { actionHandler.handle(.tap, on: action) },
            doubleTapAction: { actionHandler.handle(.doubleTap, on: action) },
            longPressAction: { actionHandler.handle(.longPress, on: action) },
            pressAction: { actionHandler.handle(.press, on: action) },
            releaseAction: { actionHandler.handle(.release, on: action) },
            repeatAction: { actionHandler.handle(.repeatPress, on: action) },
            dragAction: { start, current in actionHandler.handleDrag(on: action, from: start, to: current) })
    }
    
    @ViewBuilder
    func withLocaleContextMenu(
        for context: KeyboardContext?) -> some View {
        if let context = context {
            keyboardContextMenu(items: context.locales) { (locale: Locale) in
                Button(locale.localizedAndCapitalized, action: { context.locale = locale })
            }
        } else {
            self
        }
    }
}


private extension Locale {
    var localizedAndCapitalized: String {
        let text = localizedString(forIdentifier: identifier) ?? "-"
        return text.capitalized
    }
}
