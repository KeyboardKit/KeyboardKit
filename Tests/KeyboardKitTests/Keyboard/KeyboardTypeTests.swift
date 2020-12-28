//
//  KeyboardTypeTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
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

        
        describe("can be replaced with keyboard type") {
            
            func result(from type: KeyboardType, to newType: KeyboardType) -> Bool {
                type.canBeReplaced(with: newType)
            }
            
            it("can change for most combinations") {
                expect(result(from: .alphabetic(.lowercased), to: .alphabetic(.uppercased))).to(beTrue())
                expect(result(from: .alphabetic(.uppercased), to: .alphabetic(.lowercased))).to(beTrue())
                expect(result(from: .alphabetic(.capsLocked), to: .alphabetic(.lowercased))).to(beTrue())
                expect(result(from: .emojis, to: .numeric)).to(beTrue())
            }
            
            it("cannot change from alpha caps to alpha upper") {
                expect(result(from: .alphabetic(.capsLocked), to: .alphabetic(.uppercased))).to(beFalse())
            }
        }

    }
}
