//
//  KeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can return
 keyboard input sets.
 
 `KeyboardKit` will automatically create a standard instance
 and bind it to the input view controller when the extension
 is started. You can use it and replace it with a custom one.
 */
public protocol KeyboardInputSetProvider: AnyObject {
    
    func alphabeticInputSet() -> AlphabeticKeyboardInputSet
    func numericInputSet() -> NumericKeyboardInputSet
    func symbolicInputSet() -> SymbolicKeyboardInputSet
}
