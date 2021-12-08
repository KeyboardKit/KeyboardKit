//
//  KeyboardActionRowsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardActionRowsTests: QuickSpec {
    
    override func spec() {
        
        describe("creating keyboard action rows from string arrays") {
            
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
