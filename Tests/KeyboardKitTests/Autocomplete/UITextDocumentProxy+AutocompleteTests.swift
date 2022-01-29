//
//  UITextDocumentProxy+AutocompleteTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Quick
import Nimble
import MockingKit
import KeyboardKit

class UITextDocumentProxy_AutocompleteTests: QuickSpec {
    
    override func spec() {
        
        var proxy: MockTextDocumentProxy!
        
        let word = "REPLACE"
        let suggestion = StandardAutocompleteSuggestion(word)
        
        beforeEach {
            proxy = MockTextDocumentProxy()
        }
        
        func setupProxy(_ before: String, _ after: String) {
            proxy.documentContextBeforeInput = before
            proxy.documentContextAfterInput = after
        }
        
        func insertAutocompleteSuggestionWithMockAdjustments() {
            proxy.insertAutocompleteSuggestion(suggestion)
            if proxy.hasCalled(proxy.insertTextRef, numberOfTimes: 2) {
                proxy.documentContextBeforeInput = " "
            }
        }
        
        describe("insert autocomplete suggestion") {
            
            it("inserts word and space in empty proxy") {
                proxy.documentContextBeforeInput = ""
                insertAutocompleteSuggestionWithMockAdjustments()
                let delete = proxy.calls(to: proxy.deleteBackwardRef)
                let insert = proxy.calls(to: proxy.insertTextRef)
                expect(proxy.hasAutocompleteInsertedSpace).to(beTrue())
                expect(delete.count).to(equal(0))
                expect(insert.count).to(equal(2))
                expect(insert[0].arguments).to(equal(word))
                expect(insert[1].arguments).to(equal(" "))
            }
            
            it("inserts word and space when input is within a current word") {
                setupProxy("foo", "bar")
                insertAutocompleteSuggestionWithMockAdjustments()
                let delete = proxy.calls(to: proxy.deleteBackwardRef)
                let insert = proxy.calls(to: proxy.insertTextRef)
                expect(proxy.hasAutocompleteInsertedSpace).to(beTrue())
                expect(delete.count).to(equal(6))
                expect(insert.count).to(equal(2))
                expect(insert[0].arguments).to(equal(word))
                expect(insert[1].arguments).to(equal(" "))
            }

            it("inserts word and space when input has a leading space") {
                setupProxy("foo ", "bar")
                insertAutocompleteSuggestionWithMockAdjustments()
                let delete = proxy.calls(to: proxy.deleteBackwardRef)
                let insert = proxy.calls(to: proxy.insertTextRef)
                expect(proxy.hasAutocompleteInsertedSpace).to(beTrue())
                expect(delete.count).to(equal(3))
                expect(insert.count).to(equal(2))
                expect(insert[0].arguments).to(equal(word))
                expect(insert[1].arguments).to(equal(" "))
            }

            it("inserts only word when input has a trailing space") {
                setupProxy("foo", " bar")
                insertAutocompleteSuggestionWithMockAdjustments()
                let delete = proxy.calls(to: proxy.deleteBackwardRef)
                let insert = proxy.calls(to: proxy.insertTextRef)
                expect(proxy.hasAutocompleteInsertedSpace).to(beFalse())
                expect(delete.count).to(equal(3))
                expect(insert.count).to(equal(1))
                expect(insert[0].arguments).to(equal(word))
            }
            
            it("inserts only word if insert space is explicitly disabled") {
                setupProxy("foo ", "bar")
                proxy.insertAutocompleteSuggestion(suggestion, tryInsertSpace: false)
                let delete = proxy.calls(to: proxy.deleteBackwardRef)
                let insert = proxy.calls(to: proxy.insertTextRef)
                expect(delete.count).to(equal(3))
                expect(insert.count).to(equal(1))
                expect(insert[0].arguments).to(equal(word))
            }
        }
        
        describe("removing autocomplete inserted space") {
            
            it("doesn't do anything if no auto inserted space exists") {
                setupProxy("foo ", "bar")
                proxy.insertAutocompleteSuggestion(suggestion, tryInsertSpace: false)
                proxy.resetCalls()
                proxy.tryRemoveAutocompleteInsertedSpace()
                let delete = proxy.calls(to: proxy.deleteBackwardRef)
                expect(delete.count).to(equal(0))
            }
            
            it("backspaces once if an auto inserted space exists") {
                setupProxy("foo ", "bar")
                insertAutocompleteSuggestionWithMockAdjustments()
                proxy.resetCalls()
                proxy.tryRemoveAutocompleteInsertedSpace()
                let delete = proxy.calls(to: proxy.deleteBackwardRef)
                expect(delete.count).to(equal(1))
            }
        }
        
        describe("reinserting autocomplete removed space") {
            
            beforeEach {
                setupProxy("foo ", "bar")
                insertAutocompleteSuggestionWithMockAdjustments()
            }
            
            it("doesn't do anything if no auto removed space exists") {
                proxy.resetCalls()
                proxy.tryReinsertAutocompleteRemovedSpace()
                let insert = proxy.calls(to: proxy.insertTextRef)
                expect(insert.count).to(equal(0))
            }
            
            it("inserts a single space auto removed space exists") {
                proxy.tryRemoveAutocompleteInsertedSpace()
                proxy.resetCalls()
                proxy.tryReinsertAutocompleteRemovedSpace()
                let insert = proxy.calls(to: proxy.insertTextRef)
                expect(insert.count).to(equal(1))
            }
        }
    }
}
#endif
