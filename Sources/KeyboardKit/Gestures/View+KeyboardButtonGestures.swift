//
//  View+KeyboardGestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-21.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    typealias KeyboardGestureAction = () -> Void
    typealias KeyboardDragGestureAction = (_ startLocation: CGPoint, _ location: CGPoint) -> Void

    /**
     Apply keyboard button gestures to the view, that should
     send the gesture events to the provided `actionHandler`.

     The ``KeyboardAction/nextKeyboard`` action will trigger
     keyboard switching events instead of the action handler.

     - Parameters:
       - action: The keyboard action to trigger.
       - actionHandler: The keyboard action handler to use.
       - calloutContext: The callout context to affect, if any.
       - isPressed: An optional binding that can be used to observe the button pressed state.
       - isInScrollView: Whether or not the gestures are used in a scroll view, by default `false`.
       - releaseOutsideTolerance: The percentage of the button size that should span outside the button bounds and still count as a release, by default `0.75`.
     */
    @ViewBuilder
    func keyboardButtonGestures(
        for action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        calloutContext: KeyboardCalloutContext?,
        isPressed: Binding<Bool> = .constant(false),
        isInScrollView: Bool = false,
        releaseOutsideTolerance: Double = 1
    ) -> some View {
        self.keyboardButtonGestures(
            action: action,
            calloutContext: calloutContext,
            isPressed: isPressed,
            isInScrollView: isInScrollView,
            releaseOutsideTolerance: releaseOutsideTolerance,
            doubleTapAction: { actionHandler.handle(.doubleTap, on: action) },
            longPressAction: { actionHandler.handle(.longPress, on: action) },
            pressAction: { actionHandler.handle(.press, on: action) },
            releaseAction: { actionHandler.handle(.release, on: action) },
            repeatAction: { actionHandler.handle(.repeatPress, on: action) },
            dragAction: { start, current in actionHandler.handleDrag(on: action, from: start, to: current) }
        )
    }
    
    /**
     Apply keyboard button gestures to the view, that should
     trigger the provided gestures action.

     The ``KeyboardAction/nextKeyboard`` action will trigger
     keyboard switching instead of the provided actions.
     
     - Parameters:
       - action: The keyboard action to trigger, by deafult `nil`.
       - calloutContext: The callout context to affect, if any.
       - isPressed: An optional binding that can be used to observe the button pressed state, by deafult `false`.
       - isInScrollView: Whether or not the gestures are used in a scroll view, by default `false`, by deafult `false`.
       - releaseOutsideTolerance: The percentage of the button size that should span outside the button bounds and still count as a release, by default `0.75`.
       - doubleTapAction: The action to trigger when the button is double tapped, by deafult `nil`.
       - longPressAction: The action to trigger when the button is long pressed, by deafult `nil`.
       - pressAction: The action to trigger when the button is pressed, by deafult `nil`.
       - releaseAction: The action to trigger when the button is released, regardless of where the gesture ends, by deafult `nil`.
       - repeatAction: The action to trigger when the button is pressed and held, by deafult `nil`.
       - dragAction: The action to trigger when the button is dragged, by deafult `nil`.
     */
    @ViewBuilder
    func keyboardButtonGestures(
        action: KeyboardAction? = nil,
        calloutContext: KeyboardCalloutContext?,
        isPressed: Binding<Bool> = .constant(false),
        isInScrollView: Bool = false,
        releaseOutsideTolerance: Double = 1,
        doubleTapAction: KeyboardGestureAction? = nil,
        longPressAction: KeyboardGestureAction? = nil,
        pressAction: KeyboardGestureAction? = nil,
        releaseAction: KeyboardGestureAction? = nil,
        repeatAction: KeyboardGestureAction? = nil,
        dragAction: KeyboardDragGestureAction? = nil
    ) -> some View {
        #if os(iOS) || os(macOS) || os(watchOS)
        let gestures = KeyboardButtonGestures(
            view: self,
            action: action,
            calloutContext: calloutContext,
            isPressed: isPressed,
            isInScrollView: isInScrollView,
            releaseOutsideTolerance: releaseOutsideTolerance,
            doubleTapAction: doubleTapAction,
            longPressAction: longPressAction,
            pressAction: pressAction,
            releaseAction: releaseAction,
            repeatAction: repeatAction,
            dragAction: dragAction
        )
        #endif

        #if os(iOS)
        if action == .nextKeyboard {
            NextKeyboardButton {
                self
            }
        } else {
            gestures
        }
        #elseif os(macOS) || os(watchOS)
        gestures
        #else
        Button {
            pressAction?()
            releaseAction?()
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
