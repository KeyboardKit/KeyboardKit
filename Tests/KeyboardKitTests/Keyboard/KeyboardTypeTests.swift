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
        
        describe("can change to keyboard type") {
            
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
