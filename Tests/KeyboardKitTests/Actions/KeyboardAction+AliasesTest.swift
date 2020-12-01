//
//  KeyboardActionRowTest.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardActionRowTest: QuickSpec {
    
    override func spec() {
        
        describe("creating actions from string array") {
            
            it("converts strings to char actions") {
                let chars = ["a", "b", "c"]
                let row = KeyboardActions(characters: chars)
                expect(row.count).to(equal(3))
                expect(row[0]).to(equal(.character("a")))
                expect(row[1]).to(equal(.character("b")))
                expect(row[2]).to(equal(.character("c")))
            }
        }
        
        describe("creating row from string array") {
            
            it("converts strings to char actions") {
                let chars = ["a", "b", "c"]
                let row = KeyboardActionRow(characters: chars)
                expect(row.count).to(equal(3))
                expect(row[0]).to(equal(.character("a")))
                expect(row[1]).to(equal(.character("b")))
                expect(row[2]).to(equal(.character("c")))
            }
        }
        
        describe("creating rows from string arrays") {
            
            it("converts strings to char actions") {
                let chars = [["a", "b"], ["c"]]
                let rows = KeyboardActionRows(characters: chars)
                expect(rows.count).to(equal(2))
                expect(rows[0].count).to(equal(2))
                expect(rows[1].count).to(equal(1))
                expect(rows[0][0]).to(equal(.character("a")))
                expect(rows[0][1]).to(equal(.character("b")))
                expect(rows[1][0]).to(equal(.character("c")))
            }
        }
    }
}
