//
//  KeyboardTypeTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardTypeTests: QuickSpec {
    
    override func spec() {
        
        describe("is alphabetic") {
            
            func result(for type: KeyboardType) -> Bool {
                type.isAlphabetic
            }
            
            it("is only true for alphabetic types") {
                expect(result(for: .alphabetic(.lowercased))).to(beTrue())
                expect(result(for: .alphabetic(.uppercased))).to(beTrue())
                expect(result(for: .alphabetic(.capsLocked))).to(beTrue())
                expect(result(for: .numeric)).to(beFalse())
                expect(result(for: .symbolic)).to(beFalse())
                expect(result(for: .email)).to(beFalse())
                expect(result(for: .emojis)).to(beFalse())
                expect(result(for: .images)).to(beFalse())
                expect(result(for: .images)).to(beFalse())
                expect(result(for: .custom(""))).to(beFalse())
            }
        }
    }
}
