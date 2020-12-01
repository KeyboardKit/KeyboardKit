//
//  KeyboardInputSet+ItalianTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardInputSetTests: QuickSpec {
    
    override func spec() {
        
        describe("italian input sets") {
            
            func rows(in set: KeyboardInputSet) -> Int {
                set.inputRows.count
            }
            
            it("are the same as the English ones") {
                expect(rows(in: .italianAlphabetic)).to(equal(rows(in: .englishAlphabetic)))
                expect(rows(in: .italianNumeric)).to(equal(rows(in: .englishNumeric)))
                expect(rows(in: .italianSymbolic)).to(equal(rows(in: .englishSymbolic)))
            }
        }
    }
}
