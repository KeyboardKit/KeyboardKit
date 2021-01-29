//
//  SwedishKeyboardInputSetProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class SwedishKeyboardInputSetProviderTests: QuickSpec {
    
    override func spec() {
        
        var context: KeyboardContext!
        var provider: KeyboardInputSetProvider!
        
        beforeEach {
            context = MockKeyboardContext()
            provider = SwedishKeyboardInputSetProvider()
        }
        
        describe("input set provider") {
            
            it("has correct alphabetic input set") {
                expect(provider.alphabeticInputSet(for: context).inputRows).to(equal([
                    ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "å"],
                    ["a", "s", "d", "f", "g", "h", "j", "k", "l", "ö", "ä"],
                    ["z", "x", "c", "v", "b", "n", "m"]
                ]))
            }
            
            it("has correct numeric input set") {
                let rows = provider.numericInputSet(for: context).inputRows
                let expected = NumericKeyboardInputSet.standard(currency: "kr").inputRows
                expect(rows).to(equal(expected))
            }
            
            it("has correct symbolic input set") {
                let rows = provider.symbolicInputSet(for: context).inputRows
                let expected = SymbolicKeyboardInputSet.standard(currencies: ["€", "$", "£"]).inputRows
                expect(rows).to(equal(expected))
            }
        }
    }
}
