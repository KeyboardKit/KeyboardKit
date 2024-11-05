//
//  View+KeyboardGestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-21.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    typealias KeyboardGestureAction = () -> Void
    typealias KeyboardDragGestureAction = (_ startLocation: CGPoint, _ location: CGPoint) -> Void

    /// Apply keyboard button gestures that use the provided
    /// `actionHandler` to trigger gesture actions.
    ///
    /// The ``KeyboardAction/nextKeyboard`` action type will
    /// trigger system events instead of this action handler.
    ///
    /// - Parameters:
    ///   - action: The keyboard action to trigger.
    ///   - actionHandler: The keyboard action handler to use.
    ///   - repeatTimer: The repeat gesture timer to use, if any.
    ///   - calloutContext: The callout context to affect, if any.
    ///   - isPressed: An optional binding that can be used to observe the button pressed state.
    ///   - scrollState: The scroll state to use, if any.
    ///   - releaseOutsideTolerance: A custom percentage of the button size outside its bounds to count as a release, if any.
    func keyboardButtonGestures(
        for action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        repeatTimer: GestureButtonTimer? = nil,
        calloutContext: KeyboardCalloutContext?,
        isPressed: Binding<Bool> = .constant(false),
        scrollState: GestureButtonScrollState? = nil,
        releaseOutsideTolerance: Double = 1
    ) -> some View {
        self.keyboardButtonGestures(
            action: action,
            repeatTimer: repeatTimer,
            calloutContext: calloutContext,
            isPressed: isPressed,
            scrollState: scrollState,
            releaseOutsideTolerance: releaseOutsideTolerance,
            doubleTapAction: { actionHandler.handle(.doubleTap, on: action) },
            longPressAction: { actionHandler.handle(.longPress, on: action) },
            pressAction: { actionHandler.handle(.press, on: action) },
            releaseAction: { actionHandler.handle(.release, on: action) },
            repeatAction: { actionHandler.handle(.repeatPress, on: action) },
            dragAction: { start, current in actionHandler.handleDrag(on: action, from: start, to: current) },
            endAction: { actionHandler.handle(.end, on: action) }
        )
    }

    /// Apply keyboard button gestures that will trigger the
    /// provided actions.
    ///
    /// The ``KeyboardAction/nextKeyboard`` action type will
    /// trigger system events instead of these actions.
    ///
    /// - Parameters:
    ///   - action: The keyboard action to trigger, if any.
    ///   - repeatTimer: The repeat gesture timer to use, if any.
    ///   - calloutContext: The callout context to affect, if any.
    ///   - isPressed: An optional binding that can be used to observe the button pressed state, if any.
    ///   - scrollState: The scroll state to use, if any.
    ///   - releaseOutsideTolerance: A custom percentage of the button size outside its bounds to count as a release, if any.
    ///   - doubleTapAction: The action to trigger when the button is double tapped, if any.
    ///   - longPressAction: The action to trigger when the button is long pressed, if any.
    ///   - pressAction: The action to trigger when the button is pressed, if any.
    ///   - releaseAction: The action to trigger when the button is released, regardless of where the gesture ends, if any.
    ///   - repeatAction: The action to trigger when the button is pressed and held, if any.
    ///   - dragAction: The action to trigger when the button is dragged, if any.
    ///   - endAction: The action to trigger when the button gesture ends.
    @ViewBuilder
    func keyboardButtonGestures(
        action: KeyboardAction? = nil,
        repeatTimer: GestureButtonTimer? = nil,
        calloutContext: KeyboardCalloutContext? = nil,
        isPressed: Binding<Bool> = .constant(false),
        scrollState: GestureButtonScrollState? = nil,
        releaseOutsideTolerance: Double? = nil,
        doubleTapAction: KeyboardGestureAction? = nil,
        longPressAction: KeyboardGestureAction? = nil,
        pressAction: KeyboardGestureAction? = nil,
        releaseAction: KeyboardGestureAction? = nil,
        repeatAction: KeyboardGestureAction? = nil,
        dragAction: KeyboardDragGestureAction? = nil,
        endAction: KeyboardGestureAction? = nil
    ) -> some View {
        #if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
        let gestures = Gestures.KeyboardButtonGestures(
            view: self,
            action: action,
            repeatTimer: repeatTimer,
            calloutContext: calloutContext,
            isPressed: isPressed,
            scrollState: scrollState,
            releaseOutsideTolerance: releaseOutsideTolerance,
            doubleTapAction: doubleTapAction,
            longPressAction: longPressAction,
            pressAction: pressAction,
            releaseAction: releaseAction,
            repeatAction: repeatAction,
            dragAction: dragAction,
            endAction: endAction
        )
        #endif

        #if os(iOS) || os(visionOS)
        switch action {
        case .nextKeyboard:
            Keyboard.NextKeyboardButton {
                self
            }
        default:
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
