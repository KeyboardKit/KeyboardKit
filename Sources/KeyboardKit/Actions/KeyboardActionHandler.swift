//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This protocol can be implemented by any classes that can be
 used to handle keyboard actions.
 
 `KeyboardKit` will automatically create a standard instance
 when the keyboard input view controller is created. You can
 use the standard instance as is or replace it with a custom
 one if you want to customize your keyboard.
 */
public protocol KeyboardActionHandler: AnyObject {
    
    /**
     Whether or not the action handler can be used to handle
     a certain `gesture` on a certain `action`.
     */
    func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction) -> Bool
    
    /**
     Try to handling a certain `gesture` n a certain `action`.
     */
    func handle(_ gesture: KeyboardGesture, on action: KeyboardAction)
    
    /**
     Handle a drag gesture on a certain action, from a start
     location to the drag gesture's current location.
     */
    func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint)
}
