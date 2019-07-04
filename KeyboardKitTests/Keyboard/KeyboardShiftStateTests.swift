//
//  KeyboardShiftStateTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardShiftStateTests: QuickSpec {
    
    override func spec() {
        
        describe("is uppercased") {
            
            func result(for state: KeyboardShiftState) -> Bool {
                return state.isUppercased
            }
            
            it("only applies to uppercased and capslocked states") {
                expect(result(for: .lowercased)).to(beFalse())
                expect(result(for: .uppercased)).to(beTrue())
                expect(result(for: .capsLocked)).to(beTrue())
            }
        }
    }
}
