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
 
 KeyboardKit automatically creates an implementation of this
 protocol and binds it to ``KeyboardInputViewController``.
 */
public protocol KeyboardInputSetProvider: AnyObject {
    
    /**
     The input set to use for alphabetic keyboards.
     */
    var alphabeticInputSet: AlphabeticKeyboardInputSet { get }

    /**
     The input set to use for numeric keyboards.
     */
    var numericInputSet: NumericKeyboardInputSet { get }

    /**
     The input set to use for symbolic keyboards.
     */
    var symbolicInputSet: SymbolicKeyboardInputSet { get }
}
