//
//  StandardKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This standard keyboard inputset provider is used by default
 by KeyboardKit, and provides the standard input set for the
 current locale, if any. You can inherit and customize it to
 create your own provider that builds on this foundation.
 
 The dictionaries contain the currently supported input sets.
 They are not part of the protocol, but you can use them and
 extend them in your own subclasses.
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

    public let alphabeticInputSet: AlphabeticKeyboardInputSet
    public let numericInputSet: NumericKeyboardInputSet
    public let symbolicInputSet: SymbolicKeyboardInputSet
}
