//
//  SecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to get secondary callout actions for a keyboard action.
 
 `KeyboardKit` will automatically create a standard instance
 when the keyboard input view controller is created. You can
 use the standard instance as is or replace it with a custom
 one if you want to customize your keyboard.
 */
public protocol SecondaryCalloutActionProvider {
    
    func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction]
}
