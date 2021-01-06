//
//  KeyboardInputSet+NumericTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardInputSet_NumericTests: QuickSpec {
    
    override func spec() {
        
        describe("numeric input sets") {
            
            it("are correctly setup") {
                expect(KeyboardInputSet.numeric_de).to(equal(KeyboardInputSet.numeric_eu))
                expect(KeyboardInputSet.numeric_en).to(equal(KeyboardInputSet.standardNumeric(currency: "$")))
                expect(KeyboardInputSet.numeric_eu).to(equal(KeyboardInputSet.standardNumeric(currency: "€")))
                expect(KeyboardInputSet.numeric_it).to(equal(KeyboardInputSet.numeric_eu))
                expect(KeyboardInputSet.numeric_sv).to(equal(KeyboardInputSet.standardNumeric(currency: "kr")))
            }
        }
        
        describe("standard parts") {
            
            it("are correctly setup") {
                expect(KeyboardInputSet.standardNumericTop).to(equal(["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]))
                expect(KeyboardInputSet.standardNumericBottom).to(equal([".", ",", "?", "!", "´"]))
                
                expect(KeyboardInputSet.standardNumeric(currency: "$$$")).to(equal(
                    NumericKeyboardInputSet(inputRows: [
                        KeyboardInputSet.standardNumericTop,
                        ["-", "/", ":", ";", "(", ")", "$$$", "&", "@", "\""],
                        KeyboardInputSet.standardNumericBottom
                    ])
                ))
            }
        }
    }
}
