//
//  UITextDocumentProxy+CurrentWordTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Quick
import Nimble
import KeyboardKit
import MockingKit

class UITextDocumentProxy_CurrentWordTests: QuickSpec {
    
    override func spec() {
        
        var proxy: MockTextDocumentProxy!
        
        var delimiters: [String] { return proxy.wordDelimiters }
        
        beforeEach {
            proxy = MockTextDocumentProxy()
        }
        
        
        describe("current word") {
            
            it("returns nil if before and after context is missing") {
                let result = proxy.currentWord
                expect(result).to(beNil())
            }
            
            it("returns before context if after context is missing") {
                proxy.documentContextBeforeInput = "this must work"
                let result = proxy.currentWord
                expect(result).to(equal("work"))
            }
            
            it("returns after context if before context is missing") {
                proxy.documentContextAfterInput = "work this must"
                let result = proxy.currentWord
                expect(result).to(equal("work"))
            }
            
            it("returns before and after context if before are set") {
                proxy.documentContextBeforeInput = "I am cur"
                proxy.documentContextAfterInput = "rently writing stuff"
                let result = proxy.currentWord
                expect(result).to(equal("currently"))
            }
        }
        
        describe("current word pre cursor part") {
            
            it("returns nil if before context is missing") {
                let result = proxy.currentWordPreCursorPart
                expect(result).to(beNil())
            }
            
            it("returns empty string if context is empty") {
                proxy.documentContextBeforeInput = ""
                let result = proxy.currentWordPreCursorPart
                expect(result).to(equal(""))
            }
            
            it("extracts last word if no delimiter is present") {
                let expected = "expected"
                proxy.documentContextBeforeInput = "this is expected"
                let result = proxy.currentWordPreCursorPart
                expect(result).to(equal(expected))
            }
            
            it("stops at the specified word delimiters") {
                let expected = "expected"
                delimiters.forEach {
                    let prefix = "do not include" + $0
                    let before = prefix + expected
                    proxy.documentContextBeforeInput = before
                    let result = proxy.currentWordPreCursorPart
                    expect(result).to(equal(expected))
                }
            }
        }
        
        describe("current word post cursor part") {
            
            it("returns nil if after context is missing") {
                let result = proxy.currentWordPostCursorPart
                expect(result).to(beNil())
            }
            
            it("returns empty string if context is empty") {
                proxy.documentContextAfterInput = ""
                let result = proxy.currentWordPostCursorPart
                expect(result).to(equal(""))
            }
            
            it("extracts last word if no delimiter is present") {
                let expected = "expected"
                proxy.documentContextAfterInput = "expected this is"
                let result = proxy.currentWordPostCursorPart
                expect(result).to(equal(expected))
            }
            
            it("stops at the specified word delimiters") {
                let expected = "expected"
                delimiters.forEach {
                    let suffix = $0 + "do not include"
                    let after = expected + suffix
                    proxy.documentContextAfterInput = after
                    let result = proxy.currentWordPostCursorPart
                    expect(result).to(equal(expected))
                }
            }
        }
        
        describe("is cursor at the end of the current word") {
            
            it("returns false if current word is missing") {
                let result = proxy.isCursorAtTheEndOfTheCurrentWord
                expect(result).to(beFalse())
            }
            
            it("returns false if cursor is in the middle of a word") {
                proxy.documentContextBeforeInput = "foo"
                proxy.documentContextAfterInput = "bat"
                let result = proxy.isCursorAtTheEndOfTheCurrentWord
                expect(result).to(beFalse())
            }
            
            it("returns false if cursor is at the beginning of a word") {
                proxy.documentContextBeforeInput = ""
                proxy.documentContextAfterInput = "Hello"
                let result = proxy.isCursorAtTheEndOfTheCurrentWord
                expect(result).to(beFalse())
            }
            
            it("returns false if cursor is after a word delimiter") {
                proxy.documentContextBeforeInput = "."
                proxy.documentContextAfterInput = "Hello"
                let result = proxy.isCursorAtTheEndOfTheCurrentWord
                expect(result).to(beFalse())
            }
            
            it("returns false if cursor is after a word delimiter") {
                proxy.documentContextBeforeInput = " "
                proxy.documentContextAfterInput = "Hello"
                let result = proxy.isCursorAtTheEndOfTheCurrentWord
                expect(result).to(beFalse())
            }
            
            it("returns true if cursor is at the end of the current word") {
                proxy.documentContextBeforeInput = "Period"
                proxy.documentContextAfterInput = ""
                let result = proxy.isCursorAtTheEndOfTheCurrentWord
                expect(result).to(beTrue())
            }
        }
        
        describe("replacing current word") {
            
            context("when current word is missing") {
                
                beforeEach {
                    proxy.replaceCurrentWord(with: "another text")
                }
                
                it("aborts if current word is missing") {
                    let adjust = proxy.calls(to: proxy.adjustTextPositionRef)
                    let delete = proxy.calls(to: proxy.deleteBackwardRef)
                    let insert = proxy.calls(to: proxy.insertTextRef)
                    expect(adjust.count).to(equal(0))
                    expect(delete.count).to(equal(0))
                    expect(insert.count).to(equal(0))
                }
            }
            
            context("when current word has no post custor part") {
                
                beforeEach {
                    proxy.documentContextBeforeInput = "this a text"
                    proxy.replaceCurrentWord(with: "replacement")
                }
                
                it("does not adjust text position") {
                    let calls = proxy.calls(to: proxy.adjustTextPositionRef)
                    expect(calls.count).to(equal(1))
                    expect(calls[0].arguments).to(equal(0))
                }
                
                it("deletes backwards current word count times") {
                    let calls = proxy.calls(to: proxy.deleteBackwardRef)
                    expect(calls.count).to(equal(4))
                }
                
                it("inserts replacement text") {
                    let calls = proxy.calls(to: proxy.insertTextRef)
                    expect(calls.count).to(equal(1))
                    expect(calls[0].arguments).to(equal("replacement"))
                }
            }
            
            context("when current word has no pre custor part") {
                
                beforeEach {
                    proxy.documentContextAfterInput = "Objective-C is great"
                    proxy.replaceCurrentWord(with: "Swift")
                }
                
                it("adjusts text position post cursor count times") {
                    let calls = proxy.calls(to: proxy.adjustTextPositionRef)
                    expect(calls.count).to(equal(1))
                    expect(calls[0].arguments).to(equal(11))
                }
                
                it("deletes backwards current word count times") {
                    let calls = proxy.calls(to: proxy.deleteBackwardRef)
                    expect(calls.count).to(equal(11))
                }
                
                it("inserts replacement text") {
                    let calls = proxy.calls(to: proxy.insertTextRef)
                    expect(calls.count).to(equal(1))
                    expect(calls[0].arguments).to(equal("Swift"))
                }
            }
            
            context("when current word has pre and post custor parts") {
                
                beforeEach {
                    proxy.documentContextBeforeInput = "I think Obj"
                    proxy.documentContextAfterInput = "ective-C is great"
                    proxy.replaceCurrentWord(with: "Swift")
                }
                
                it("adjusts text position post cursor count times") {
                    let calls = proxy.calls(to: proxy.adjustTextPositionRef)
                    expect(calls.count).to(equal(1))
                    expect(calls[0].arguments).to(equal(8))
                }
                
                it("deletes backwards current word count times") {
                    let calls = proxy.calls(to: proxy.deleteBackwardRef)
                    expect(calls.count).to(equal(11))
                }
                
                it("inserts replacement text") {
                    let calls = proxy.calls(to: proxy.insertTextRef)
                    expect(calls.count).to(equal(1))
                    expect(calls[0].arguments).to(equal("Swift"))
                }
            }
        }
    }
}
#endif
