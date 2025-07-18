//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/// This protocol can be implemented by any classes that can
/// handle triggered ``KeyboardAction`` events.
///
/// Call the various `handle` functions to handle any action,
/// action gesture and autocomplete suggestion. You can also
/// use ``triggerFeedback(for:on:)`` to trigger audio/haptic
/// feedback at any time.
///
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the keyboard action handling.
public protocol KeyboardActionHandler: AnyObject, FeedbackService {


    /// Whether the handler can handle an action gesture.
    func canHandle(
        _ gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Bool
    
    /// Handle a certain keyboard action.
    func handle(
        _ action: KeyboardAction
    )
    
    /// Handle a certain keyboard action gesture.
    func handle(
        _ gesture: Keyboard.Gesture,
        on action: KeyboardAction
    )
    
    /// Handle a certain autocomplete suggestion.
    func handle(
        _ suggestion: Autocomplete.Suggestion
    )

    /// Handle a certain keyboard action drag gesture.
    func handleDrag(
        on action: KeyboardAction,
        from startLocation: CGPoint,
        to currentLocation: CGPoint
    )
    
    /// Trigger feedback for a certain action gesture.
    func triggerFeedback(
        for gesture: Keyboard.Gesture,
        on action: KeyboardAction
    )
}

public extension KeyboardActionHandler {

    /// Handle a certain keyboard action.
    func handle(
        action: KeyboardAction
    ) {
        handle(action)
    }

    /// Handle a certain autocomplete suggestion.
    func handle(
        suggestion: Autocomplete.Suggestion
    ) {
        handle(suggestion)
    }
}
