//
//  KeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to provide a keyboard layout with input sets.
 
 An input set defines the input keys on a keyboard. The keys
 can then be used to create a layout, which defines the full
 set of keys, described as layout items.
 
 `KeyboardKit` will automatically create a standard instance
 when the keyboard input view controller is created. You can
 use the standard instance as is or replace it with a custom
 one if you want to customize your keyboard.
 */
public protocol KeyboardInputSetProvider: AnyObject {
    
    /**
     Get the alphabetic input set to use.
     */
    var alphabeticInputSet: AlphabeticKeyboardInputSet { get }

    /**
     Get the numeric input set to use.
     */
    var numericInputSet: NumericKeyboardInputSet { get }

    /**
     Get the symbolic input set to use.
     */
    var symbolicInputSet: SymbolicKeyboardInputSet { get }
}
