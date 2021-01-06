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
 input sets, e.g. for the keyboard extension's current state.
 
 KeyboardKit registers a standard protocol implementation in
 the input view controller's `context` when the extension is
 started. You can replace this at any time, by registering a
 new provider with the `keyboardInputProvider` property.

 `IMPORTANT` This is an experimental new feature, that could
 be redesigned in any minor release until 4.0.
 */
public protocol KeyboardInputSetProvider: AnyObject {
    
    func alphabeticInputSet(for context: KeyboardContext) -> AlphabeticKeyboardInputSet
    func numericInputSet(for context: KeyboardContext) -> NumericKeyboardInputSet
    func symbolicInputSet(for context: KeyboardContext) -> SymbolicKeyboardInputSet
}
