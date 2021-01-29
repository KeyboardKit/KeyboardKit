//
//  NumericKeyboardInputSetTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class NumericKeyboardInputSetTests: QuickSpec {
    
    override func spec() {
        
        describe("standard") {
            
            func validate(rows: [KeyboardInputSet.InputRow], for currency: String) -> Bool {
                rows == [
                    ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                    ["-", "/", ":", ";", "(", ")", currency, "&", "@", "\""],
                    [".", ",", "?", "!", "’"]
                ]
            }
            
            it("is valid for $ currency") {
                let rows = NumericKeyboardInputSet.standard(currency: "$").inputRows
                expect(validate(rows: rows, for: "$")).to(beTrue())
            }
            
            it("is valid for SEK currency") {
                let rows = NumericKeyboardInputSet.standard(currency: "kr").inputRows
                expect(validate(rows: rows, for: "kr")).to(beTrue())
            }
        }
    }
}
