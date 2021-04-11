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
 and bind it to the input view controller when the extension
 is started. You can use it and replace it with a custom one.
 */
public protocol KeyboardActionHandler: AnyObject {
    
    func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction) -> Bool
    func handle(_ gesture: KeyboardGesture, on action: KeyboardAction)
    func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint)
}
