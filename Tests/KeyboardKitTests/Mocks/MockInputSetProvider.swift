//
//  MockInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit

class MockInputSetProvider: Mock, InputSetProvider {
    
    var alphabeticInputSetValue: AlphabeticInputSet = AlphabeticInputSet(rows: [])
    var numericInputSetValue: NumericInputSet = NumericInputSet(rows: [])
    var symbolicInputSetValue: SymbolicInputSet = SymbolicInputSet(rows: [])
    
    var alphabeticInputSet: AlphabeticInputSet { alphabeticInputSetValue }
    var numericInputSet: NumericInputSet { numericInputSetValue }
    var symbolicInputSet: SymbolicInputSet { symbolicInputSetValue }
}
