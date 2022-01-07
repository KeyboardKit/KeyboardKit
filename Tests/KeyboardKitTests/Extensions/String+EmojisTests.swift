//
//  String+Emojis.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-07.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class String_EmojisTests: QuickSpec {
    
    override func spec() {
        
        describe("contains emojis") {
            
            func result(for str: String) -> Bool {
                str.containsEmoji
            }
            
            it("returns true if the string contains emojis") {
                expect(result(for: "abc")).to(beFalse())
                expect(result(for: "a👍c")).to(beTrue())
            }
        }
        
        describe("contains only emojis") {
            
            func result(for str: String) -> Bool {
                str.containsOnlyEmojis
            }
            
            it("returns true if the string only contains emojis") {
                expect(result(for: "abc")).to(beFalse())
                expect(result(for: "a👍c")).to(beFalse())
                expect(result(for: "👍")).to(beTrue())
            }
        }
        
        describe("emojis") {
            
            func result(for str: String) -> [Character] {
                str.emojis
            }
            
            it("returns true if the string only contains emojis") {
                expect(result(for: "abc")).to(equal([]))
                expect(result(for: "a👍c")).to(equal(["👍"]))
                expect(result(for: "smile🙂👍ok")).to(equal(["🙂", "👍"]))
            }
        }
        
        describe("emoji scalars") {
            
            func result(for str: String) -> [UnicodeScalar] {
                str.emojiScalars
            }
            
            it("returns true if the string only contains emojis") {
                expect(result(for: "abc")).to(equal([]))
                expect(result(for: "a👍c")).to(equal(["👍"]))
                expect(result(for: "smile🙂👍ok")).to(equal(["🙂", "👍"]))
            }
        }
        
        describe("emoji string") {
            
            func result(for str: String) -> String {
                str.emojiString
            }
            
            it("returns true if the string only contains emojis") {
                expect(result(for: "abc")).to(equal(""))
                expect(result(for: "a👍c")).to(equal("👍"))
                expect(result(for: "smile🙂👍ok")).to(equal("🙂👍"))
            }
        }
        
        describe("is single emoji") {
            
            func result(for str: String) -> Bool {
                str.isSingleEmoji
            }
            
            it("returns true if the string only contains a single emojis") {
                expect(result(for: "abc")).to(beFalse())
                expect(result(for: "👍")).to(beTrue())
                expect(result(for: "a👍c")).to(beFalse())
            }
        }
    }
}
