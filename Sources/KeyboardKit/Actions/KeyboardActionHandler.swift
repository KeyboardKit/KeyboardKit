//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This protocol can be implemented by classes that can handle
 ``KeyboardAction``s.
 
 KeyboardKit will register a ``StandardKeyboardActionHandler``
 with ``KeyboardInputViewController/services``.
 
 To change how keyboard actions are handled by your keyboard,
 you can implement a custom provider.

 To create a custom implementation of this protocol, you can
 either implement the protocol from scratch, or subclass the
 standard class and override what you want to change. Inject
 it into ``KeyboardInputViewController/services`` to make it
 be used as the global default.
 */
public protocol KeyboardActionHandler: AnyObject {
    
    /// This typealias resolves to a keyboard gesture
    typealias Gesture = Gestures.KeyboardGesture
    
    /// Whether or not the handler handles an action gesture.
    func canHandle(
        _ gesture: Gesture,
        on action: KeyboardAction
    ) -> Bool
    
    /// Handle a certain action using its standard action.
    func handle(
        _ action: KeyboardAction
    )
    
    /// Handle a certain autocomplete suggestion.
    func handle(
        _ suggestion: Autocomplete.Suggestion
    )

    /// Handle a certain action gesture.
    func handle(
        _ gesture: Gesture,
        on action: KeyboardAction
    )
    
    /// Handle a drag gesture on a certain action.
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
