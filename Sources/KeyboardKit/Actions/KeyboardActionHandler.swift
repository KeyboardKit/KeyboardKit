//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This protocol can be implemented by classes that can handle
 ``KeyboardAction`` events.
 
 KeyboardKit will create a ``StandardKeyboardActionHandler``
 instance when the keyboard extension is started, then apply
 it to ``KeyboardInputViewController/keyboardActionHandler``.
 It will then use this instance by default to handle actions.
 
 Many keyboard actions have standard behaviors, while others
 don't and require custom handling. To customize how actions
 are handled, you can implement a custom action handler.
 
 You can create a custom implementation of this protocol, by
 inheriting and customizing the standard class or creating a
 new implementation from scratch. When you're implementation
 is ready, just replace the controller service with your own
 implementation to make the library use it instead.
 */
public protocol KeyboardActionHandler: AnyObject {
    
    /**
     Whether or not this action handler can handle a certain
     `gesture` on a certain `action`.
     */
    func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction) -> Bool
    
    /**
     Handle a certain `gesture` on a certain `action`.
     */
    func handle(_ gesture: KeyboardGesture, on action: KeyboardAction)
    
    /**
     Handle a drag gesture on a certain action, from a start
     location to the drag gesture's current location.
     */
    func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint)
}
