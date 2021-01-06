//
//  KeyboardInputSet+Numeric.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This file contains various numeric input sets.
 */
public extension KeyboardInputSet {
    
    static var numeric_de: NumericKeyboardInputSet {
        numeric_eu
    }
    
    static var numeric_en: NumericKeyboardInputSet {
        standardNumeric(currency: "$")
    }
    
    static var numeric_eu: NumericKeyboardInputSet {
        standardNumeric(currency: "€")
    }
    
    static var numeric_it: NumericKeyboardInputSet {
        numeric_eu
    }
    
    static var numeric_sv: NumericKeyboardInputSet {
        standardNumeric(currency: "kr")
    }
}


// MARK: - Standard

public extension KeyboardInputSet {
    
    static func standardNumeric(currency: String) -> NumericKeyboardInputSet {
        NumericKeyboardInputSet(inputRows: [
            standardNumericTop,
            ["-", "/", ":", ";", "(", ")", currency, "&", "@", "\""],
            standardNumericBottom
        ])
    }
    
    static var standardNumericTop: [String] {
        ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    }
    
    static var standardNumericBottom: [String] {
        [".", ",", "?", "!", "´"]
    }
}
