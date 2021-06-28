//
//  KeyboardCasingTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardCasingTests: QuickSpec {
    
    override func spec() {
        
        describe("is lowercased") {
            
            func result(for state: KeyboardCasing) -> Bool {
                return state.isLowercased
            }
            
            it("only applies to certain states") {
                expect(result(for: .auto)).to(beFalse())
                expect(result(for: .capsLocked)).to(beFalse())
                expect(result(for: .lowercased)).to(beTrue())
                expect(result(for: .neutral)).to(beFalse())
                expect(result(for: .uppercased)).to(beFalse())
            }
        }
        
        describe("is uppercased") {
            
            func result(for state: KeyboardCasing) -> Bool {
                return state.isUppercased
            }
            
            it("only applies to certain states") {
                expect(result(for: .auto)).to(beFalse())
                expect(result(for: .capsLocked)).to(beTrue())
                expect(result(for: .lowercased)).to(beFalse())
                expect(result(for: .neutral)).to(beFalse())
                expect(result(for: .uppercased)).to(beTrue())
            }
        }
    }
}
