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
 ``KeyboardAction`` events in various ways.
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
