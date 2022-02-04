//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This protocol can be implemented by classes that can handle
 ``KeyboardAction`` events.
 
 Many views in the library use actions and an action handler.
 This gives you a very flexible setup, where you can use the
 actions you want, then dynamically handle the actions using
 an action handler.
 
 Just call ``handle(_:on:)`` on an action handler to trigger
 an action programatically. This is convenient when you have
 to trigger actions from other parts of your custom keyboard.
 
 KeyboardKit will create a ``StandardKeyboardActionHandler``
 instance when the keyboard extension is started, then apply
 it to ``KeyboardInputViewController/keyboardActionHandler``.
 It will then use this instance by default to handle actions.
 You can use this action handler in your own code as well.
 
 Many keyboard actions have standard behaviors that are used
 by default by the library. To customize how the actions are
 handled, you can implement a custom ``KeyboardActionHandler``.
 
 You can create a custom action handler by either inheriting
 and customizing the ``StandardKeyboardActionHandler`` class
 or by implementing ``KeyboardActionHandler`` in a brand new
 implementation. Inheriting ``StandardKeyboardActionHandler``
 is highly recommended, since you get a bunch of implemented
 logic that you can override with your own custom logic.
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
