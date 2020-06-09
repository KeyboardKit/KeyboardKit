//
//  KeyboardActionsTest.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-06-09.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardActionsTest: QuickSpec {
    
    override func spec() {
        
        describe("creating row from string array") {
            
            it("converts strings to char actions") {
                let chars = ["a", "b", "c"]
                let row = KeyboardActions(characters: chars)
                expect(row.count).to(equal(3))
                expect(row[0]).to(equal(.character("a")))
                expect(row[1]).to(equal(.character("b")))
                expect(row[2]).to(equal(.character("c")))
            }
        }
    }
}
