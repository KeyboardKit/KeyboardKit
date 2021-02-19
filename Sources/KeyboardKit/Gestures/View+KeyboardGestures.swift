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
     provided keyboard action and action handler.
     
     If you provide an optional `KeyboardContext` the action
     can get even more contextual actions.
     */
    @ViewBuilder
    func keyboardGestures(
        for action: KeyboardAction,
        context: KeyboardContext? = nil,
        isPressed: Binding<Bool> = .constant(false),
        actionHandler: KeyboardActionHandler) -> some View {
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
     provided keyboard action blocks.
     
     Some actions require a keyboard action, like updating a
     callout contexts.
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
            self.localeContextMenu(for: context)
        } else {
            self
        }
    }
}
