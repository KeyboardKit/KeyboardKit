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
 
 KeyboardKit registers a standard protocol implementation in
 the keyboard context when the extension is started. You can
 replace this at any time, by applying a new instance to the
 context's `keyboardInputSetProvider` property.
 */
public protocol KeyboardInputSetProvider: AnyObject {
    
    func alphabeticInputSet(for context: KeyboardContext) -> AlphabeticKeyboardInputSet
    func numericInputSet(for context: KeyboardContext) -> NumericKeyboardInputSet
    func symbolicInputSet(for context: KeyboardContext) -> SymbolicKeyboardInputSet
}
