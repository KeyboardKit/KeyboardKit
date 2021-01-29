//
//  SymbolicKeyboardInputSetTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class SymbolicKeyboardInputSetTests: QuickSpec {
    
    override func spec() {
        
        describe("standard") {
            
            func validate(rows: [KeyboardInputSet.InputRow], for currencies: [String]) -> Bool {
                rows == [
                    ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
                    ["_", "\\", "|", "~", "<", ">"] + currencies + ["•"],
                    [".", ",", "?", "!", "’"]
                ]
            }
            
            it("is valid for European currencies") {
                let currencies = ["€", "£", "¥"]
                let rows = SymbolicKeyboardInputSet.standard(currencies: currencies).inputRows
                expect(validate(rows: rows, for: currencies)).to(beTrue())
            }
            
            it("is valid for Swedish currency") {
                let currencies = ["€", "$", "£"]
                let rows = SymbolicKeyboardInputSet.standard(currencies: currencies).inputRows
                expect(validate(rows: rows, for: currencies)).to(beTrue())
            }
        }
    }
}
