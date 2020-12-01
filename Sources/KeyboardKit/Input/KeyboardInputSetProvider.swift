//
//  KeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can return
 input sets, e.g. for the keyboard extension's current state.
 
 KeyboardKit registers a standard protocol implementation in
 the input view controller's `context` when the extension is
 started. You can replace this at any time, by registering a
 new instance with the `inputSetProvider` property.
 */
public protocol KeyboardInputSetProvider: AnyObject {
    
    var alphabeticInputSet: AlphabeticKeyboardInputSet { get }
    var numericInputSet: NumericKeyboardInputSet { get }
    var symbolicInputSet: SymbolicKeyboardInputSet { get }
}
