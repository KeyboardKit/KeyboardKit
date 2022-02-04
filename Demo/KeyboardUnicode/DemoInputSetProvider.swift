//
//  DemoInputSetProvider.swift
//  KeyboardUnicode
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo-specific input set provider replaces the standard
 English alphabetical input set with a unicode one.
 
 For some unicode keyboards, the numeric and symbolic inputs
 make no sense. If so, you should create a custom layout and
 remove the numeric/symbolic switches.
 */
class DemoInputSetProvider: DeviceSpecificInputSetProvider {
    
    let baseProvider = EnglishInputSetProvider()
    
    var alphabeticInputSet: AlphabeticInputSet {
        AlphabeticInputSet(rows: [
            row(lowercased: "qẅëṛẗÿüïöṗ", uppercased: "QẄЁṚṪŸÜЇÖṖ"),
            row(lowercased: "äṡḋḟġḧjḳḷ", uppercased: "ÄṠḊḞĠḦJḲḶ"),
            row(
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
