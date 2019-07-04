//
//  KeyboardActionRowsTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardActionRowsTest: QuickSpec {
    
    override func spec() {
        
        describe("creating rows from string arrays") {
            
            it("converts strings to char actions") {
                let chars = [["a", "b"], ["c"]]
                let rows = KeyboardActionRows.from(chars)
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
