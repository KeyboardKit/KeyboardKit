//
//  UITextDocumentProxy+ContentTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Quick
import Nimble
import KeyboardKit
import MockingKit

class UITextDocumentProxy_ContentTests: QuickSpec {
    
    override func spec() {
        
        var proxy: MockTextDocumentProxy!
        
        beforeEach {
            proxy = MockTextDocumentProxy()
        }
        
        func prepareProxy(with preCursorPart: String, _ postCursorPart: String? = nil) {
            proxy.documentContextBeforeInput = preCursorPart
            proxy.documentContextAfterInput = postCursorPart
        }
        
        describe("is cursor at the beginning of a new sentence") {
            
            func result(for preCursorPart: String) -> Bool {
                prepareProxy(with: preCursorPart)
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
            
            it("returns false if pre cursor has an unclosed sentence and a newline") {
                expect(result(for: "foo\n")).to(beFalse())
            }
            
            it("returns false if pre cursor has a closed sentence and a newline") {
                expect(result(for: "foo!\n")).to(beTrue())
            }
        }
        
        describe("is cursor at the beginning of a new sentence with space") {
            
            func result(for preCursorPart: String) -> Bool {
                prepareProxy(with: preCursorPart)
                return proxy.isCursorAtNewSentenceWithSpace
            }
            
            it("returns true if pre cursor part is missing") {
                expect(proxy.isCursorAtNewSentence).to(beTrue())
            }
            
            it("returns true if pre cursor is empty or ends with a sentence delimiter") {
                expect(result(for: "")).to(beTrue())
            }
            
            it("returns false if pre cursor part ends with a non-sentence delimiter") {
                expect(result(for: "foo")).to(beFalse())
            }
            
            it("returns false if pre cursor ends with a sentence delimiter") {
                expect(result(for: "foo.")).to(beFalse())
            }
            
            it("returns false if pre cursor has an unclosed sentence and a newline") {
                expect(result(for: "foo\n")).to(beFalse())
            }
            
            it("returns true if pre cursor has a closed sentence and a newline") {
                expect(result(for: "foo!\n")).to(beTrue())
            }
            
            it("returns false if pre cursor ends with a sentence delimiter followed by spaces") {
                expect(result(for: "foo. ")).to(beTrue())
                expect(result(for: "foo.   ")).to(beTrue())
            }
        }
        
        describe("is cursor at the beginning of a new word") {
            
            func result(for preCursorPart: String) -> Bool {
                prepareProxy(with: preCursorPart)
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
        
        describe("sentence before input") {
            
            func result(for preCursorPart: String, _ postCursorPart: String) -> String? {
                prepareProxy(with: preCursorPart, postCursorPart)
                return proxy.sentenceBeforeInput
            }
            
            it("returns last ended sentence, if any") {
                expect(result(for: "", "")).to(beNil())
                expect(result(for: "sentence", "")).to(beNil())
                expect(result(for: "sentence.", "")).to(equal("sentence"))
                expect(result(for: "sentence!", "")).to(equal("sentence"))
                expect(result(for: "sentence .", "")).to(equal("sentence "))
                expect(result(for: "sentence. ", "")).to(beNil())
                expect(result(for: "sentence. a", "")).to(beNil())
                expect(result(for: "sentence.a", "")).to(beNil())
            }
        }
        
        describe("last ended word before input") {
            
            func result(for preCursorPart: String, _ postCursorPart: String) -> String? {
                prepareProxy(with: preCursorPart, postCursorPart)
                return proxy.wordBeforeInput
            }
            
            it("returns previous word if one exists and the cursor is not at the beginning of a new sentence") {
                expect(result(for: "word", "")).to(beNil())
                expect(result(for: "word ", "")).to(equal("word"))
                expect(result(for: "word. ", "")).to(beNil())
                expect(result(for: "one two . three ", "")).to(equal("three"))
                expect(result(for: "word...", "")).to(beNil())
                expect(result(for: "word,,,", "")).to(beNil())
                expect(result(for: "word,", "")).to(equal("word"))
                expect(result(for: "word, ", "")).to(beNil())
            }
        }
        
        describe("sentence delimiter list") {
            
            it("is shorthand to static String property") {
                expect(proxy.sentenceDelimiters).to(equal(String.sentenceDelimiters))
            }
        }
        
        describe("trimmed document context after input") {
            
            it("removes whitespace") {
                proxy.documentContextAfterInput = " foo "
                expect(proxy.trimmedDocumentContextAfterInput).to(equal("foo"))
            }
        }
        
        describe("trimmed document context before input") {
            
            it("removes whitespace") {
                proxy.documentContextBeforeInput = " bar "
                expect(proxy.trimmedDocumentContextBeforeInput).to(equal("bar"))
            }
        }
        
        describe("word delimiter list") {
            
            it("is shorthand to static String property") {
                expect(proxy.wordDelimiters).to(equal(String.wordDelimiters))
            }
        }
    }
}
#endif
