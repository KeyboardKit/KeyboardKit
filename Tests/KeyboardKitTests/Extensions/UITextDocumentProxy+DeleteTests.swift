//
//  UITextDocumentProxy+DeleteTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import MockingKit

@testable import KeyboardKit

class UITextDocumentProxy_DeleteTests: QuickSpec {
    
    override func spec() {
        
        var proxy: MockTextDocumentProxy!
        
        var delimiters: [String] { return proxy.wordDelimiters }
        
        beforeEach {
            proxy = MockTextDocumentProxy()
        }
        
        
        describe("deleting backwards certain number of times") {
            
            it("calls delete backwards correct number of times") {
                proxy.deleteBackward(times: 11)
                let delete = proxy.calls(to: proxy.deleteBackwardRef)
                expect(delete.count).to(equal(11))
            }
        }
        
        
        describe("deleting backwards for range") {
            
            func result(for range: DeleteBackwardRange, _ expected: Int) -> Bool {
                proxy.deleteBackward(range)
                return proxy.hasCalled(proxy.deleteBackwardRef, numberOfTimes: expected)
            }
            
            it("does not delete if no text exists before input") {
                proxy.documentContextBeforeInput = nil
                expect(result(for: .char, 0)).to(beTrue())
                expect(result(for: .word, 0)).to(beTrue())
                expect(result(for: .sentence, 0)).to(beTrue())
            }
            
            context("char range") {
                
                it("deletes last char") {
                    proxy.documentContextBeforeInput = "abc 123 "
                    expect(result(for: .char, 1)).to(beTrue())
                }
            }
            
            context("word range") {
                
                it("returns single word segment including trailing space") {
                    proxy.documentContextBeforeInput = "abc "
                    expect(result(for: .word, 4)).to(beTrue())
                }
                
                it("returns last word segment including trailing space") {
                    proxy.documentContextBeforeInput = "abc 123 "
                    expect(result(for: .word, 4)).to(beTrue())
                }
            }
            
            context("sentence range") {
                
                it("returns single sentence segment including trailing space") {
                    proxy.documentContextBeforeInput = "abc 123. "
                    expect(result(for: .sentence, 9)).to(beTrue())
                }
                
                it("returns last sentence segment including trailing space") {
                    proxy.documentContextBeforeInput = "foo bar! abc 123. "
                    expect(result(for: .sentence, 10)).to(beTrue())
                }
            }
        }
        
        
        describe("delete backwards text for range") {
            
            func result(for range: DeleteBackwardRange) -> String? {
                proxy.deleteBackwardText(for: range)
            }
            
            it("returns nil if no text exists before input") {
                proxy.documentContextBeforeInput = nil
                expect(result(for: .char)).to(beNil())
                expect(result(for: .word)).to(beNil())
                expect(result(for: .sentence)).to(beNil())
            }
            
            context("char range") {
                
                it("returns last char") {
                    proxy.documentContextBeforeInput = "abc 123 "
                    expect(result(for: .char)).to(equal(" "))
                }
            }
            
            context("word range") {
                
                it("returns single word segment including trailing space") {
                    proxy.documentContextBeforeInput = "abc "
                    expect(result(for: .word)).to(equal("abc "))
                }
                
                it("returns last word segment including trailing space") {
                    proxy.documentContextBeforeInput = "abc 123 "
                    expect(result(for: .word)).to(equal("123 "))
                }
            }
            
            context("sentence range") {
                
                it("returns single sentence segment including trailing space") {
                    proxy.documentContextBeforeInput = "abc 123. "
                    expect(result(for: .sentence)).to(equal("abc 123. "))
                }
                
                it("returns last sentence segment including trailing space") {
                    proxy.documentContextBeforeInput = "foo bar! abc 123. "
                    expect(result(for: .sentence)).to(equal(" abc 123. "))
                }
            }
        }
    }
}
