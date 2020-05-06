//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be implemented by classes that can handle
 triggered keyboard actions.
 
 A `StandardKeyboardActionHandler` is used by default by the
 `KeyboardInputViewController` class, but you can replace it
 with any custom action handler. See the demo for an example.
 */
public protocol KeyboardActionHandler: AnyObject {
    
    func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?)
}

public extension KeyboardActionHandler {
    
    func handle(_ gesture: KeyboardGesture, on action: KeyboardAction) {
        handle(gesture, on: action, sender: nil)
    }
}
