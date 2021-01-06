//
//  KeyboardInputSet+AlphabeticTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardInputSet_AlphabeticTests: QuickSpec {
    
    override func spec() {
        
        describe("alphabetic input sets") {
            
            it("are correctly setup") {
                expect(KeyboardInputSet.alphabetic_de.inputRows.count).to(equal(3))
                expect(KeyboardInputSet.alphabetic_en.inputRows.count).to(equal(3))
                expect(KeyboardInputSet.alphabetic_it).to(equal(KeyboardInputSet.alphabetic_en))
                expect(KeyboardInputSet.alphabetic_sv.inputRows.count).to(equal(3))
            }
        }
    }
}
