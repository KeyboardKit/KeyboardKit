//
//  KeyboardInputSet+English.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardInputSet {
    
    @available(*, deprecated, renamed: "alphabetic_en")
    static var english: AlphabeticKeyboardInputSet { .alphabetic_en }
    
    @available(*, deprecated, renamed: "numeric_en")
    static var englishNumeric: NumericKeyboardInputSet { .numeric_en }
    
    @available(*, deprecated, renamed: "symbolic_en")
    static var englishSymbolic: SymbolicKeyboardInputSet { .symbolic_en }
}
