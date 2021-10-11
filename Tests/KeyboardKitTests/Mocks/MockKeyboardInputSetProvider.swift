//
//  MockKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit

class MockKeyboardInputSetProvider: Mock, KeyboardInputSetProvider {
    
    var alphabeticInputSetValue: AlphabeticKeyboardInputSet = AlphabeticKeyboardInputSet(rows: [])
    var numericInputSetValue: NumericKeyboardInputSet = NumericKeyboardInputSet(rows: [])
    var symbolicInputSetValue: SymbolicKeyboardInputSet = SymbolicKeyboardInputSet(rows: [])
    
    var alphabeticInputSet: AlphabeticKeyboardInputSet { alphabeticInputSetValue }
    var numericInputSet: NumericKeyboardInputSet { numericInputSetValue }
    var symbolicInputSet: SymbolicKeyboardInputSet { symbolicInputSetValue }
}
