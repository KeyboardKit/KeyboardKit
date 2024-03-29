//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/// This protocol can be implemented by any classes that can
/// handle triggered ``KeyboardAction`` events.
///
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the keyboard action behavior.
///
/// To create a custom implementation, either implement this
/// protocol from scratch, or inherit the standard class and
/// override what you want to change. You can then inject it
/// into ``KeyboardInputViewController/services`` to make it
/// the global default.
public protocol KeyboardActionHandler: AnyObject {
    
    /// This typealias resolves to a keyboard gesture
    typealias Gesture = Gestures.KeyboardGesture
    
    /// Whether the handler can handle an action gesture.
    func canHandle(
        _ gesture: Gesture,
        on action: KeyboardAction
    ) -> Bool
    
    /// Handle a certain keyboard action.
    func handle(
        _ action: KeyboardAction
    )
    
    /// Handle a certain keyboard action gesture.
    func handle(
        _ gesture: Gesture,
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
        for gesture: Gesture,
        on action: KeyboardAction
    )
}
