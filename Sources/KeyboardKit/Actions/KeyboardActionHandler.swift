//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be implemented by classes that can handle
 keyboard actions.
 
 `KeyboardKit` will automatically create a standard instance
 when the extension is started and bind it to the input view
 controller. It can be replaced with a custom one by setting
 the input view controller's `actionHandler` property.
 */
public protocol KeyboardActionHandler: AnyObject {
    
    func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) -> Bool
    func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?)
    func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint)
}

public extension KeyboardActionHandler {
    
    func handle(_ gesture: KeyboardGesture, on action: KeyboardAction) {
        handle(gesture, on: action, sender: nil)
    }
}
