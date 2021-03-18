//
//  UITextDocumentProxy+AutocompleteTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import MockingKit
import KeyboardKit

class UITextDocumentProxy_AutocompleteTests: QuickSpec {
    
    override func spec() {
        
        let word = "REPLACE"
        
        var proxy: MockTextDocumentProxy!
        
        beforeEach {
            proxy = MockTextDocumentProxy()
        }
        
        describe("handle autocomplete suggestion") {
            
            let suggestion = StandardAutocompleteSuggestion(word)
            
            it("deletes backwards correctly") {
                proxy.documentContextBeforeInput = ""
                proxy.insertAutocompleteSuggestion(suggestion)
                
            }
            
            it("inserts word and space in empty proxy") {
                proxy.documentContextBeforeInput = ""
                proxy.insertAutocompleteSuggestion(suggestion)
                let deleteCalls = proxy.calls(to: proxy.deleteBackwardRef)
                let insertCalls = proxy.calls(to: proxy.insertTextRef)
                expect(deleteCalls.count).to(equal(0))
                expect(insertCalls.count).to(equal(2))
                expect(insertCalls[0].arguments).to(equal(word))
                expect(insertCalls[1].arguments).to(equal(" "))
            }
            
            it("inserts word and space in non-empty proxy where input has no surrounding spaces") {
                proxy.documentContextBeforeInput = "foo"
                proxy.documentContextAfterInput = "bar"
                proxy.insertAutocompleteSuggestion(suggestion)
                let deleteCalls = proxy.calls(to: proxy.deleteBackwardRef)
                let insertCalls = proxy.calls(to: proxy.insertTextRef)
                expect(deleteCalls.count).to(equal(6))
                expect(insertCalls.count).to(equal(2))
                expect(insertCalls[0].arguments).to(equal(word))
                expect(insertCalls[1].arguments).to(equal(" "))
            }

            it("inserts word and space in non-empty proxy where input has leading space") {
                proxy.documentContextBeforeInput = "foo "
                proxy.documentContextAfterInput = "bar"
                proxy.insertAutocompleteSuggestion(suggestion)
                let deleteCalls = proxy.calls(to: proxy.deleteBackwardRef)
                let insertCalls = proxy.calls(to: proxy.insertTextRef)
                expect(deleteCalls.count).to(equal(3))
                expect(insertCalls.count).to(equal(2))
                expect(insertCalls[0].arguments).to(equal(word))
                expect(insertCalls[1].arguments).to(equal(" "))
            }

            it("inserts only word in non-empty proxy where input has trailing space") {
                proxy.documentContextBeforeInput = "foo"
                proxy.documentContextAfterInput = " bar"
                proxy.insertAutocompleteSuggestion(suggestion)
                let deleteCalls = proxy.calls(to: proxy.deleteBackwardRef)
                let insertCalls = proxy.calls(to: proxy.insertTextRef)
                expect(deleteCalls.count).to(equal(3))
                expect(insertCalls.count).to(equal(1))
                expect(insertCalls[0].arguments).to(equal(word))
            }
        }
    }
}
