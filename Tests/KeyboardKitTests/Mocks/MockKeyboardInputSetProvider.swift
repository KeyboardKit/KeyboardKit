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
    
    func alphabeticInputSet() -> AlphabeticKeyboardInputSet { alphabeticInputSetValue }
    func numericInputSet() -> NumericKeyboardInputSet { numericInputSetValue }
    func symbolicInputSet() -> SymbolicKeyboardInputSet { symbolicInputSetValue }
}
