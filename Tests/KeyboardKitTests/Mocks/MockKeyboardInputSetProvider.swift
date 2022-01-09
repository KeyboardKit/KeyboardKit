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
    
    var alphabeticInputSetValue: AlphabeticInputSet = AlphabeticInputSet(rows: [])
    var numericInputSetValue: NumericInputSet = NumericInputSet(rows: [])
    var symbolicInputSetValue: SymbolicInputSet = SymbolicInputSet(rows: [])
    
    var alphabeticInputSet: AlphabeticInputSet { alphabeticInputSetValue }
    var numericInputSet: NumericInputSet { numericInputSetValue }
    var symbolicInputSet: SymbolicInputSet { symbolicInputSetValue }
}
