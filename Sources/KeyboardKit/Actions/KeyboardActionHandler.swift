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
 
 KeyboardKit registers a standard protocol implementation in
 the input view controller's `context` when the extension is
 started. You can replace this by registering a new instance
 with the `actionHandler` property.
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
