//
//  DemoInputSetProvider.swift
//  KeyboardUnicode
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo-specific `InputSetProvider` can be used to create
 a custom, Unicode-based input set.

 Note that for some Unicode keyboards, it makes little sense
 to have a numeric and a symbolic keyboard. If so, you could
 create a custom `KeyboardLayoutProvider` that removes these
 keyboard switches.
 */
class DemoInputSetProvider: InputSetProvider {
    
    let baseProvider = EnglishInputSetProvider()
    
    var alphabeticInputSet: AlphabeticInputSet {
        AlphabeticInputSet(rows: [
            .init(lowercased: "qẅëṛẗÿüïöṗ", uppercased: "QẄЁṚṪŸÜЇÖṖ"),
            .init(lowercased: "äṡḋḟġḧjḳḷ", uppercased: "ÄṠḊḞĠḦJḲḶ"),
            .init(
                phoneLowercased: "żẍċṿḅṅṁ",
                phoneUppercased: "ŻẌĊṾḄṄṀ",
                padLowercased: "żẍċṿḅṅṁ,.",
                padUppercased: "ŻẌĊṾḄṄṀ,.")
        ])
    }
    
    var numericInputSet: NumericInputSet {
        baseProvider.numericInputSet
    }
    
    var symbolicInputSet: SymbolicInputSet {
        baseProvider.symbolicInputSet
    }
}
