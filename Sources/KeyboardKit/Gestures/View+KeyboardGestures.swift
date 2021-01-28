//
//  View+KeyboardGestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-21.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    typealias KeyboardGestureAction = () -> Void
    typealias KeyboardDragGestureAction = (_ startLocation: CGPoint, _ location: CGPoint) -> Void
    
    /**
     Apply keyboard-specific gestures to the view, using the
     provided keyboard action and action handler.
     */
    @ViewBuilder
    func keyboardGestures(
        for action: KeyboardAction,
        actionHandler: KeyboardActionHandler) -> some View {
        if action == .nextKeyboard {
            self
        } else {
            self.keyboardGestures(
                action: action,
                tapAction: { actionHandler.handle(.tap, on: action) },
                doubleTapAction: { actionHandler.handle(.doubleTap, on: action) },
                longPressAction: { actionHandler.handle(.longPress, on: action) },
                repeatAction: { actionHandler.handle(.repeatPress, on: action) },
                dragAction: { start, current in actionHandler.handleDrag(on: action, from: start, to: current) })
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
        tapAction: KeyboardGestureAction? = nil,
        doubleTapAction: KeyboardGestureAction? = nil,
        longPressAction: KeyboardGestureAction? = nil,
        repeatAction: KeyboardGestureAction? = nil,
        dragAction: KeyboardDragGestureAction? = nil,
        inputCalloutContext: InputCalloutContext = .shared,
        secondaryInputCalloutContext: SecondaryInputCalloutContext = .shared) -> some View {
        KeyboardGestures(
            view: self,
            action: action,
            tapAction: tapAction,
            doubleTapAction: doubleTapAction,
            longPressAction: longPressAction,
            repeatAction: repeatAction,
            dragAction: dragAction,
            inputCalloutContext: inputCalloutContext,
            secondaryInputCalloutContext: secondaryInputCalloutContext)
    }
}
