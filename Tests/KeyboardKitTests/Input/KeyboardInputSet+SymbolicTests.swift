//
//  KeyboardInputSet+SymbolicTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardInputSet_SymbolicTests: QuickSpec {
    
    override func spec() {
        
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
                expect(KeyboardInputSet.standardSymbolicTop).to(equal(["[", "]", "{", "}", "#", "%", "^", "*", "+", "="]))
                expect(KeyboardInputSet.standardSymbolicBottom).to(equal([".", ",", "?", "!", "´"]))
                
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
