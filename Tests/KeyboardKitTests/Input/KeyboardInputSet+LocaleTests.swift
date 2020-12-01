//
//  KeyboardInputSet+LocaleTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardInputSet_LocaleTests: QuickSpec {
    
    override func spec() {
        
        describe("alphabetic input sets") {
            
            it("are correctly setup") {
                expect(KeyboardInputSet.alphabetic_de.inputRows.count).to(equal(3))
                expect(KeyboardInputSet.alphabetic_en.inputRows.count).to(equal(3))
                expect(KeyboardInputSet.alphabetic_it).to(equal(KeyboardInputSet.alphabetic_en))
                expect(KeyboardInputSet.alphabetic_sv.inputRows.count).to(equal(3))
            }
        }
        
        describe("numeric input sets") {
            
            it("are correctly setup") {
                expect(KeyboardInputSet.numeric_de).to(equal(KeyboardInputSet.numeric_eu))
                expect(KeyboardInputSet.numeric_en).to(equal(KeyboardInputSet.standardNumeric(currency: "$")))
                expect(KeyboardInputSet.numeric_eu).to(equal(KeyboardInputSet.standardNumeric(currency: "€")))
                expect(KeyboardInputSet.numeric_it).to(equal(KeyboardInputSet.numeric_eu))
                expect(KeyboardInputSet.numeric_sv).to(equal(KeyboardInputSet.standardNumeric(currency: "kr")))
            }
        }
        
        describe("symbolic input sets") {
            
            it("are correctly setup") {
                expect(KeyboardInputSet.symbolic_de).to(equal(KeyboardInputSet.symbolic_eu))
                expect(KeyboardInputSet.symbolic_en).to(equal(KeyboardInputSet.standardSymbolic(center: ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"])))
                expect(KeyboardInputSet.symbolic_eu).to(equal(KeyboardInputSet.standardSymbolic(center: ["_", "\\", "|", "~", "<", ">", "$", "£", "¥", "•"])))
                expect(KeyboardInputSet.symbolic_it).to(equal(KeyboardInputSet.symbolic_eu))
                expect(KeyboardInputSet.symbolic_sv).to(equal(KeyboardInputSet.standardSymbolic(center: ["_", "\\", "|", "~", "<", ">", "€", "$", "£", "•"])))
            }
        }
        
        describe("standard parts") {
            
            it("are correctly setup") {
                expect(KeyboardInputSet.standardNumericTop).to(equal(["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]))
                expect(KeyboardInputSet.standardNumericBottom).to(equal([".", ",", "?", "!", "´"]))
                expect(KeyboardInputSet.standardSymbolicTop).to(equal(["[", "]", "{", "}", "#", "%", "^", "*", "+", "="]))
                expect(KeyboardInputSet.standardSymbolicBottom).to(equal([".", ",", "?", "!", "´"]))
                
                expect(KeyboardInputSet.standardNumeric(currency: "$$$")).to(equal(
                    NumericKeyboardInputSet(inputRows: [
                        KeyboardInputSet.standardNumericTop,
                        ["-", "/", ":", ";", "(", ")", "$$$", "&", "@", "\""],
                        KeyboardInputSet.standardNumericBottom
                    ])
                ))
                
                expect(KeyboardInputSet.standardSymbolic(center: ["a", "b", "c"])).to(equal(
                    SymbolicKeyboardInputSet(inputRows: [
                        KeyboardInputSet.standardSymbolicTop,
                        ["a", "b", "c"],
                        KeyboardInputSet.standardSymbolicBottom
                    ])
                ))
            }
        }
    }
}
