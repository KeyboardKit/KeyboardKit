//
//  StaticInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This input set provider just returns the input sets that it
 was initialized with.
 */
public class StaticInputSetProvider: InputSetProvider {
    
    /**
     Create a static provider.
     
      - Parameters:
        - alphabeticInputSet: The alphabetic input set to use.
        - numericInputSet: The numeric input set to use.
        - symbolicInputSet: The symbolic input set to use.
     */
    public init(
        alphabeticInputSet: AlphabeticInputSet,
        numericInputSet: NumericInputSet,
        symbolicInputSet: SymbolicInputSet
    ) {
        self.alphabeticInputSetValue = alphabeticInputSet
        self.numericInputSetValue = numericInputSet
        self.symbolicInputSetValue = symbolicInputSet
    }
    
    /**
     Create a static, empty provider.
     */
    public static var empty: InputSetProvider {
        StaticInputSetProvider(
            alphabeticInputSet: AlphabeticInputSet(rows: []),
            numericInputSet: NumericInputSet(rows: []),
            symbolicInputSet: SymbolicInputSet(rows: []))
    }
    
    private let alphabeticInputSetValue: AlphabeticInputSet
    private let numericInputSetValue: NumericInputSet
    private let symbolicInputSetValue: SymbolicInputSet

    /**
     The alphabetic input set to use.
     */
    public var alphabeticInputSet: AlphabeticInputSet {
        alphabeticInputSetValue
    }
    
    /**
     The numeric input set to use.
     */
    public var numericInputSet: NumericInputSet {
        numericInputSetValue
    }
    
    /**
     The symbolic input set to use.
     */
    public var symbolicInputSet: SymbolicInputSet {
        symbolicInputSetValue
    }
}
