//
//  StaticKeyboardInputProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This keyboard input set provider returns the input set that
 it is initialized with.
 
 It can be used to return a static input set, without taking
 factors like locales into consideration.
 */
public class StaticKeyboardInputProvider: KeyboardInputProvider {
    
    public init(
        alphabeticInputSet: AlphabeticKeyboardInputSet,
        numericInputSet: NumericKeyboardInputSet,
        symbolicInputSet: SymbolicKeyboardInputSet) {
        self.alphabeticInputSet = alphabeticInputSet
        self.numericInputSet = numericInputSet
        self.symbolicInputSet = symbolicInputSet
    }

    public let alphabeticInputSet: AlphabeticKeyboardInputSet
    public let numericInputSet: NumericKeyboardInputSet
    public let symbolicInputSet: SymbolicKeyboardInputSet
}
