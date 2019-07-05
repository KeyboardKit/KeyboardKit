//
//  String+UppercasedTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class String_UppercasedTests: QuickSpec {
    
    override func spec() {
        
        describe("uppercasing string array") {
            
            it("uppercases all children") {
                let array = ["a", "b", "c"]
                let expected = ["A", "B", "C"]
                expect(array.uppercased()).to(equal(expected))
            }
        }
        
        describe("uppercasing string array with string arrays") {
            
            it("uppercases all children") {
                let array = [["a", "b"], ["c"]]
                let expected = [["A", "B"], ["C"]]
                expect(array.uppercased()).to(equal(expected))
            }
        }
    }
}
