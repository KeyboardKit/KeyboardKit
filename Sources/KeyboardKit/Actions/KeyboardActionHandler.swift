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
 keyboard actions.
 
 KeyboardKit will registers a `StandardKeyboardActionHandler`
 in the input view controller's `context` when the extension
 is started. You can replace the standard one by registering
 a new `actionHandler` in this context.
 
 `StandardKeyboardActionHandler` has a LOT of built-in logic
 that can also be overridden. If you want to create a custom
 action handler, you should probably subclass it and replace
 the parts you want to customize.
 */
public protocol KeyboardActionHandler: AnyObject {
    
    func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) -> Bool
    func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?)
}

public extension KeyboardActionHandler {
    
    func handle(_ gesture: KeyboardGesture, on action: KeyboardAction) {
        handle(gesture, on: action, sender: nil)
    }
}
