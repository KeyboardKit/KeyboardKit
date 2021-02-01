//
//  StaticKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This keyboard input set provider returns the input set that
 it was initialized with, regardless of the provided context.
 */
public class StaticKeyboardInputSetProvider: KeyboardInputSetProvider {
    
    public init(
        alphabeticInputSet: AlphabeticKeyboardInputSet,
        numericInputSet: NumericKeyboardInputSet,
        symbolicInputSet: SymbolicKeyboardInputSet) {
        self.alphabeticInputSetValue = alphabeticInputSet
        self.numericInputSetValue = numericInputSet
        self.symbolicInputSetValue = symbolicInputSet
    }
    
    public static var empty: KeyboardInputSetProvider {
        StaticKeyboardInputSetProvider(
            alphabeticInputSet: AlphabeticKeyboardInputSet(inputRows: []),
            numericInputSet: NumericKeyboardInputSet(inputRows: []),
            symbolicInputSet: SymbolicKeyboardInputSet(inputRows: []))
    }
    
    private let alphabeticInputSetValue: AlphabeticKeyboardInputSet
    private let numericInputSetValue: NumericKeyboardInputSet
    private let symbolicInputSetValue: SymbolicKeyboardInputSet

    public func alphabeticInputSet() -> AlphabeticKeyboardInputSet {
        alphabeticInputSetValue
    }
    
    public func numericInputSet() -> NumericKeyboardInputSet {
        numericInputSetValue
    }
    
    public func symbolicInputSet() -> SymbolicKeyboardInputSet {
        symbolicInputSetValue
    }
}
