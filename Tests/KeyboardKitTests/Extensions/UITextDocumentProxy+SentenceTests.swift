//
//  UITextDocumentProxy+SentenceTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class UITextDocumentProxy_SentenceTests: QuickSpec {
    
    override func spec() {
        
        var proxy: MockTextDocumentProxy!
        
        var delimiters: [String] { return proxy.wordDelimiters }
        
        beforeEach {
            proxy = MockTextDocumentProxy()
        }
        
        describe("word delimiter list") {
            
            it("is correctly setup") {
                let result = proxy.wordDelimiters
                expect(result).to(equal(["!", ".", ",", "?", ";", ":", " "]))
            }
        }
        
        
        describe("is cursor at the beginning of a new sentence") {
            
            func result(for preCursorPart: String) -> Bool {
                proxy.documentContextBeforeInput = preCursorPart
                return proxy.isCursorAtTheBeginningOfASentence
            }
            
            it("returns true if pre cursor part is missing") {
                expect(proxy.isCursorAtTheBeginningOfASentence).to(beTrue())
            }
            
            it("returns false if pre cursor part ends with a non-word delimiter") {
                expect(result(for: "foo")).to(beFalse())
            }
            
            it("returns false if pre cursor part ends with a word delimiter") {
                expect(result(for: "foo.")).to(beTrue())
                expect(result(for: "foo! ")).to(beTrue())
            }
        }
    }
}
