//
//  String+UppercasedTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class String_UppercasedTests: QuickSpec {
    
    override func spec() {

        describe("is capitalized") {

            it("is only true for capitalized strings") {
                expect("Foobar".isCapitalized).to(beTrue())
                expect("Foo Bar".isCapitalized).to(beTrue())
                expect("Foo bar".isCapitalized).to(beFalse())
            }
        }

        describe("is lowercased") {

            it("is only true for strings that can be and are lowercased") {
                expect("foobar".isLowercased).to(beTrue())
                expect("fooBar".isLowercased).to(beFalse())
                expect("123".isLowercased).to(beFalse())
            }
        }
        
        describe("is uppercased") {
            
            it("is only true for strings that can be and are uppercased") {
                expect("FOOBAR".isUppercased).to(beTrue())
                expect("fooBar".isUppercased).to(beFalse())
                expect("123".isUppercased).to(beFalse())
            }
        }

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
