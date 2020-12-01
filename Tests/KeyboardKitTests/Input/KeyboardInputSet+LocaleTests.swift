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
        
        describe("english input sets") {
            
            func rows(in set: KeyboardInputSet) -> Int {
                set.inputRows.count
            }
            
            it("are correctly setup") {
                expect(rows(in: .alphabetic_en)).to(equal(3))
                expect(rows(in: .numeric_en)).to(equal(3))
                expect(rows(in: .symbolic_en)).to(equal(3))
            }
        }
    }
}
