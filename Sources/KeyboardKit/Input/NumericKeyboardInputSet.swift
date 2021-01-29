//
//  NumericKeyboardInputSet.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-30.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This input set can used in numeric keyboards.
 */
public class NumericKeyboardInputSet: KeyboardInputSet {}

public extension NumericKeyboardInputSet {
    
    static func standard(currency: String) -> NumericKeyboardInputSet {
        NumericKeyboardInputSet(inputRows: [
            standardTopRow,
            ["-", "/", ":", ";", "(", ")", currency, "&", "@", "\""],
            standardBottomRow
        ])
    }
    
    static var standardTopRow: [String] {
        ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    }
    
    static func standardCenterRow(currency: String) -> [String] {
        ["-", "/", ":", ";", "(", ")", currency, "&", "@", "\""]
    }
    
    static var standardBottomRow: [String] {
        [".", ",", "?", "!", "’"]
    }
}
