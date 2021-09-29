//
//  KeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to generate a keyboard layout for a certain context.
 
 `KeyboardKit` will automatically create a standard instance
 when the keyboard input view controller is created. You can
 use the standard instance as is or replace it with a custom
 one if you want to customize your keyboard.
 */
public protocol KeyboardLayoutProvider: AnyObject {
    
    /**
     Get a keyboard layout for the provided context.
     */
    func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout
    
    /**
     Register a new input set provider.
     */
    func register(inputSetProvider: KeyboardInputSetProvider)
}
