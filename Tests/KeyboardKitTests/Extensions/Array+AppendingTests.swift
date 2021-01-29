//
//  Array+AppendingTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class Array_AppendingTests: QuickSpec {
    
    override func spec() {
        
        describe("appending element") {
            
            let row1: KeyboardActions = [.backspace, .control]
            let row2: KeyboardActions = [.escape, .command]
            let row3: KeyboardActions = [.function, .character("a")]
            let rows: KeyboardActionRows = [row1, row2]
            
            it("returns new collection and leaves original unaffected") {
                let result = rows.appending(row3)
                expect(rows.count).to(equal(2))
                expect(result.count).to(equal(3))
            }
        }
    }
}
