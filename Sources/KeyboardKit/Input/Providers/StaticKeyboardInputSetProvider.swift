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
    
    /**
     Create a static provider.
     
      - Parameters:
        - alphabeticInputSet: The alphabetic input set to use.
        - numericInputSet: The numeric input set to use.
        - symbolicInputSet: The symbolic input set to use.
     */
    public init(
        alphabeticInputSet: AlphabeticKeyboardInputSet,
        numericInputSet: NumericKeyboardInputSet,
        symbolicInputSet: SymbolicKeyboardInputSet) {
        self.alphabeticInputSetValue = alphabeticInputSet
        self.numericInputSetValue = numericInputSet
        self.symbolicInputSetValue = symbolicInputSet
    }
    
    /**
     Create a static, empty provider.
     */
    public static var empty: KeyboardInputSetProvider {
        StaticKeyboardInputSetProvider(
            alphabeticInputSet: AlphabeticKeyboardInputSet(rows: []),
            numericInputSet: NumericKeyboardInputSet(rows: []),
            symbolicInputSet: SymbolicKeyboardInputSet(rows: []))
    }
    
    private let alphabeticInputSetValue: AlphabeticKeyboardInputSet
    private let numericInputSetValue: NumericKeyboardInputSet
    private let symbolicInputSetValue: SymbolicKeyboardInputSet

    /**
     The alphabetic input set to use.
     */
    public var alphabeticInputSet: AlphabeticKeyboardInputSet {
        alphabeticInputSetValue
    }
    
    /**
     The numeric input set to use.
     */
    public var numericInputSet: NumericKeyboardInputSet {
        numericInputSetValue
    }
    
    /**
     The symbolic input set to use.
     */
    public var symbolicInputSet: SymbolicKeyboardInputSet {
        symbolicInputSetValue
    }
}
