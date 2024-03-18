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
 ``KeyboardAction`` gestures and events.
 
 KeyboardKit will create a ``StandardKeyboardActionHandler``
 instance when the keyboard extension is started, then apply
 it to ``KeyboardInputViewController/state``. It's then used
 as the default handler, for instance in ``SystemKeyboard``.
 
 Many actions have standard behaviors while others don't and
 therefore require a custom action handler to have an effect.
 To change how your keyboard handles actions, you can create
 a custom keyboard action handler.
 
 To create a custom implementation of this protocol, you can
 implement it from scratch or inherit the standard class and
 override the parts that you want to change. When the custom
 implementation is done, you can just replace the controller
 service to make KeyboardKit use the custom service globally.
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
