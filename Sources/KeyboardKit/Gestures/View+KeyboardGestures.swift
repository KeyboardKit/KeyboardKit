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

     - Parameters:
       - action: The keyboard action to trigger.
       - actionHandler: The keyboard action handler to use.
       - isInScrollView: Whether or not the gestures are used in a scroll view, by default `false`.
       - isPressed: An optional binding that can be used to observe the button pressed state.
     */
    @ViewBuilder
    func keyboardGestures(
        for action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        isInScrollView: Bool = false,
        isPressed: Binding<Bool> = .constant(false)
    ) -> some View {
        if action == .nextKeyboard {
            self
        } else {
            self.keyboardGestures(
                action: action,
                isInScrollView: isInScrollView,
                isPressed: isPressed,
                doubleTapAction: { actionHandler.handle(.doubleTap, on: action) },
                longPressAction: { actionHandler.handle(.longPress, on: action) },
                pressAction: { actionHandler.handle(.press, on: action) },
                releaseAction: { actionHandler.handle(.release, on: action) },
                repeatAction: { actionHandler.handle(.repeatPress, on: action) },
                dragAction: { start, current in actionHandler.handleDrag(on: action, from: start, to: current) })
        }
    }
    
    /**
     Apply keyboard-specific gestures to the view, using the
     provided action blocks.
     
     - Parameters:
       - action: The keyboard action to trigger.
       - isInScrollView: Whether or not the gestures are used in a scroll view, by default `false`.
       - isPressed: An optional binding that can be used to observe the button pressed state.
       - tapAction: The action to trigger when the button is released within its bounds.
       - doubleTapAction: The action to trigger when the button is double tapped.
       - longPressAction: The action to trigger when the button is long pressed.
       - pressAction: The action to trigger when the button is pressed.
       - releaseAction: The action to trigger when the button is released, regardless of where the gesture ends.
       - repeatAction: The action to trigger when the button is pressed and held.
       - dragAction: The action to trigger when the button is dragged.
     */
    @ViewBuilder
    func keyboardGestures(
        action: KeyboardAction? = nil,
        isInScrollView: Bool = false,
        isPressed: Binding<Bool> = .constant(false),
        doubleTapAction: KeyboardGestureAction? = nil,
        longPressAction: KeyboardGestureAction? = nil,
        pressAction: KeyboardGestureAction? = nil,
        releaseAction: KeyboardGestureAction? = nil,
        repeatAction: KeyboardGestureAction? = nil,
        dragAction: KeyboardDragGestureAction? = nil
    ) -> some View {
        #if os(iOS) || os(macOS) || os(watchOS)
        KeyboardGestures(
            view: self,
            action: action,
            isInScrollView: isInScrollView,
            isPressed: isPressed,
            doubleTapAction: doubleTapAction,
            longPressAction: longPressAction,
            pressAction: pressAction,
            releaseAction: releaseAction,
            repeatAction: repeatAction,
            dragAction: dragAction
        )
        #else
        Button {
            pressAction?()
            releaseAction?()
            tapAction?()
        } label: {
            self
        }
        #endif
    }
}

private extension Locale {
    var localizedAndCapitalized: String {
        let text = localizedString(forIdentifier: identifier) ?? "-"
        return text.capitalized
    }
}
