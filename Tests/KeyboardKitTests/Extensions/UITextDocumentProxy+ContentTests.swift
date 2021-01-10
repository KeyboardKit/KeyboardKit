//
//  UITextDocumentProxy+ContentTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class UITextDocumentProxy_ContentTests: QuickSpec {
    
    override func spec() {
        
        var proxy: MockTextDocumentProxy!
        
        beforeEach {
            proxy = MockTextDocumentProxy()
        }
        
        describe("is cursor at the beginning of a new sentence") {
            
            func result(for preCursorPart: String) -> Bool {
                proxy.documentContextBeforeInput = preCursorPart
                return proxy.isCursorAtNewSentence
            }
            
            it("returns true if pre cursor part is missing") {
                expect(proxy.isCursorAtNewSentence).to(beTrue())
            }
            
            it("returns false if pre cursor part ends with a non-sentence delimiter") {
                expect(result(for: "foo")).to(beFalse())
                expect(result(for: "foo ")).to(beFalse())
            }
            
            it("returns true if pre cursor is empty or ends with a sentence delimiter") {
                expect(result(for: "")).to(beTrue())
                expect(result(for: "foo.")).to(beTrue())
                expect(result(for: "foo! ")).to(beTrue())
            }
        }
        
        describe("is cursor at the beginning of a new word") {
            
            func result(for preCursorPart: String) -> Bool {
                proxy.documentContextBeforeInput = preCursorPart
                return proxy.isCursorAtNewWord
            }
            
            it("returns true if pre cursor part is missing") {
                expect(proxy.isCursorAtNewWord).to(beTrue())
            }
            
            it("returns false if pre cursor part ends with a non-word delimiter") {
                expect(result(for: "foo")).to(beFalse())
                expect(result(for: "foo€")).to(beFalse())
            }
            
            it("returns true if pre cursor is empty or ends with a word delimiter") {
                expect(result(for: "")).to(beTrue())
                expect(result(for: "foo.")).to(beTrue())
                expect(result(for: "foo! ")).to(beTrue())
            }
        }
        
        describe("sentence delimiter list") {
            
            it("is correctly setup") {
                let result = proxy.sentenceDelimiters
                expect(result).to(equal(["!", ".", "?", "\n"]))
            }
        }
        
        describe("word delimiter list") {
            
            it("is correctly setup") {
                let result = proxy.wordDelimiters
                expect(result).to(equal(["!", ".", "?", "\n", ",", ";", ":", " "]))
            }
        }
    }
}
