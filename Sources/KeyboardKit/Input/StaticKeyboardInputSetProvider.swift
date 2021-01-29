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
        self.alphabeticInputSet = alphabeticInputSet
        self.numericInputSet = numericInputSet
        self.symbolicInputSet = symbolicInputSet
    }
    
    public static var empty: KeyboardInputSetProvider {
        StaticKeyboardInputSetProvider(
            alphabeticInputSet: AlphabeticKeyboardInputSet(inputRows: []),
            numericInputSet: NumericKeyboardInputSet(inputRows: []),
            symbolicInputSet: SymbolicKeyboardInputSet(inputRows: []))
    }
    
    private let alphabeticInputSet: AlphabeticKeyboardInputSet
    private let numericInputSet: NumericKeyboardInputSet
    private let symbolicInputSet: SymbolicKeyboardInputSet

    public func alphabeticInputSet(for context: KeyboardContext) -> AlphabeticKeyboardInputSet {
        alphabeticInputSet
    }
    
    public func numericInputSet(for context: KeyboardContext) -> NumericKeyboardInputSet {
        numericInputSet
    }
    
    public func symbolicInputSet(for context: KeyboardContext) -> SymbolicKeyboardInputSet {
        symbolicInputSet
    }
}
