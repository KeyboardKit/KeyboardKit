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
 input sets for the keyboard extension context.
 
 `KeyboardKit` will automatically create a standard instance
 and bind it to the input view controller when the extension
 is started. It can be replaced with a custom one by setting
 the `keyboardInputSetProvider` property.
 */
public protocol KeyboardInputSetProvider: AnyObject {
    
    func alphabeticInputSet(for context: KeyboardContext) -> AlphabeticKeyboardInputSet
    func numericInputSet(for context: KeyboardContext) -> NumericKeyboardInputSet
    func symbolicInputSet(for context: KeyboardContext) -> SymbolicKeyboardInputSet
}
