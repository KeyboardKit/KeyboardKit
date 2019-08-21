//
//  UITextDocumentProxy+CurrentWordTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import KeyboardKit

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
        
        describe("replacing current word") {
            
            context("when current word is missing") {
                
                beforeEach {
                    proxy.replaceCurrentWord(with: "another text")
                }
                
                it("aborts if current word is missing") {
                    let adjust = proxy.recorder.executions(of: proxy.adjustTextPosition)
                    let delete = proxy.recorder.executions(of: proxy.deleteBackward)
                    let insert = proxy.recorder.executions(of: proxy.insertText)
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
                    let adjust = proxy.recorder.executions(of: proxy.adjustTextPosition)
                    expect(adjust.count).to(equal(1))
                    expect(adjust[0].arguments).to(equal(0))
                }
                
                it("deletes backwards current word count times") {
                    let delete = proxy.recorder.executions(of: proxy.deleteBackward)
                    expect(delete.count).to(equal(4))
                }
                
                it("inserts replacement text") {
                    let insert = proxy.recorder.executions(of: proxy.insertText)
                    expect(insert.count).to(equal(1))
                    expect(insert[0].arguments).to(equal("replacement"))
                }
            }
            
            context("when current word has no pre custor part") {
                
                beforeEach {
                    proxy.documentContextAfterInput = "Objective-C is great"
                    proxy.replaceCurrentWord(with: "Swift")
                }
                
                it("adjusts text position post cursor count times") {
                    let adjust = proxy.recorder.executions(of: proxy.adjustTextPosition)
                    expect(adjust.count).to(equal(1))
                    expect(adjust[0].arguments).to(equal(11))
                }
                
                it("deletes backwards current word count times") {
                    let delete = proxy.recorder.executions(of: proxy.deleteBackward)
                    expect(delete.count).to(equal(11))
                }
                
                it("inserts replacement text") {
                    let insert = proxy.recorder.executions(of: proxy.insertText)
                    expect(insert.count).to(equal(1))
                    expect(insert[0].arguments).to(equal("Swift"))
                }
            }
            
            context("when current word has pre and post custor parts") {
                
                beforeEach {
                    proxy.documentContextBeforeInput = "I think Obj"
                    proxy.documentContextAfterInput = "ective-C is great"
                    proxy.replaceCurrentWord(with: "Swift")
                }
                
                it("adjusts text position post cursor count times") {
                    let adjust = proxy.recorder.executions(of: proxy.adjustTextPosition)
                    expect(adjust.count).to(equal(1))
                    expect(adjust[0].arguments).to(equal(8))
                }
                
                it("deletes backwards current word count times") {
                    let delete = proxy.recorder.executions(of: proxy.deleteBackward)
                    expect(delete.count).to(equal(11))
                }
                
                it("inserts replacement text") {
                    let insert = proxy.recorder.executions(of: proxy.insertText)
                    expect(insert.count).to(equal(1))
                    expect(insert[0].arguments).to(equal("Swift"))
                }
            }
        }
    }
}
