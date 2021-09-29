//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be implemented by any classes that can be
 used to handle keyboard actions.
 
 `KeyboardKit` will automatically create a standard instance
 when the keyboard input view controller is created. You can
 use the standard instance as is or replace it with a custom
 one if you want to customize your keyboard.
 */
public protocol KeyboardActionHandler: AnyObject {
    
    func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction) -> Bool
    func handle(_ gesture: KeyboardGesture, on action: KeyboardAction)
    func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint)
}
