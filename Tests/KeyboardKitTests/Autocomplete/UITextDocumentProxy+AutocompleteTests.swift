//
//  UITextDocumentProxy+AutocompleteTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import MockingKit
import KeyboardKit
import XCTest

class UITextDocumentProxy_AutocompleteTests: XCTestCase {

    var proxy: MockTextDocumentProxy!

    let word = "REPLACE"
    var suggestion: AutocompleteSuggestion!

    override func setUp() {
        proxy = MockTextDocumentProxy()
        suggestion = StandardAutocompleteSuggestion(text: word)
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


    func testInsertAutocompleteSuggestionInsertsWordAndSpaceInEmptyProxy() {
        proxy.documentContextBeforeInput = ""
        insertAutocompleteSuggestionWithMockAdjustments()
        let delete = proxy.calls(to: proxy.deleteBackwardRef)
        let insert = proxy.calls(to: proxy.insertTextRef)
        XCTAssertTrue(proxy.hasAutocompleteInsertedSpace)
        XCTAssertEqual(delete.count, 0)
        XCTAssertEqual(insert.count, 2)
        XCTAssertEqual(insert[0].arguments, word)
        XCTAssertEqual(insert[1].arguments, " ")
    }

    func testInsertAutocompleteSuggestionInsertsWordAndSpaceWhenInputIsWithinCurrentWord() {
        setupProxy("foo", "bar")
        insertAutocompleteSuggestionWithMockAdjustments()
        let delete = proxy.calls(to: proxy.deleteBackwardRef)
        let insert = proxy.calls(to: proxy.insertTextRef)
        XCTAssertTrue(proxy.hasAutocompleteInsertedSpace)
        XCTAssertEqual(delete.count, 6)
        XCTAssertEqual(insert.count, 2)
        XCTAssertEqual(insert[0].arguments, word)
        XCTAssertEqual(insert[1].arguments, " ")
    }

    func testInsertAutocompleteSuggestionInsertsWordAndSpaceWhenInputHasLeadingSpace() {
        setupProxy("foo ", "bar")
        insertAutocompleteSuggestionWithMockAdjustments()
        let delete = proxy.calls(to: proxy.deleteBackwardRef)
        let insert = proxy.calls(to: proxy.insertTextRef)
        XCTAssertTrue(proxy.hasAutocompleteInsertedSpace)
        XCTAssertEqual(delete.count, 3)
        XCTAssertEqual(insert.count, 2)
        XCTAssertEqual(insert[0].arguments, word)
        XCTAssertEqual(insert[1].arguments, " ")
    }

    func testInsertAutocompleteSuggestionInsertsOnlyWordWhenInputHasTrailingSpace() {
        setupProxy("foo", " bar")
        insertAutocompleteSuggestionWithMockAdjustments()
        let delete = proxy.calls(to: proxy.deleteBackwardRef)
        let insert = proxy.calls(to: proxy.insertTextRef)
        XCTAssertFalse(proxy.hasAutocompleteInsertedSpace)
        XCTAssertEqual(delete.count, 3)
        XCTAssertEqual(insert.count, 1)
        XCTAssertEqual(insert[0].arguments, word)
    }

    func testInsertAutocompleteSuggestionInsertsOnlyWordIfInsertSpaceIsExplicitlyDisabled() {
        setupProxy("foo ", "bar")
        proxy.insertAutocompleteSuggestion(suggestion, tryInsertSpace: false)
        let delete = proxy.calls(to: proxy.deleteBackwardRef)
        let insert = proxy.calls(to: proxy.insertTextRef)
        XCTAssertEqual(delete.count, 3)
        XCTAssertEqual(insert.count, 1)
        XCTAssertEqual(insert[0].arguments, word)
    }


    func testRemovingAutocompleteInsertedSpaceDoesNotDoAnythingIfNoAutoInsertedSpaceExists() {
        setupProxy("foo ", "bar")
        proxy.insertAutocompleteSuggestion(suggestion, tryInsertSpace: false)
        proxy.resetCalls()
        proxy.tryRemoveAutocompleteInsertedSpace()
        let delete = proxy.calls(to: proxy.deleteBackwardRef)
        XCTAssertEqual(delete.count, 0)
    }

    func testRemovingAutocompleteInsertedSpaceBackspacesOnceIfAnAutoInsertedSpaceExists() {
        setupProxy("foo ", "bar")
        insertAutocompleteSuggestionWithMockAdjustments()
        proxy.resetCalls()
        proxy.tryRemoveAutocompleteInsertedSpace()
        let delete = proxy.calls(to: proxy.deleteBackwardRef)
        XCTAssertEqual(delete.count, 1)
    }


    func testReinsertingAutocompleteRemovedSpaceDoesNotDoAnythingIfNoAutoRemovedSpaceExists() {
        setupProxy("foo ", "bar")
        insertAutocompleteSuggestionWithMockAdjustments()
        proxy.resetCalls()
        proxy.tryReinsertAutocompleteRemovedSpace()
        let insert = proxy.calls(to: proxy.insertTextRef)
        XCTAssertEqual(insert.count, 0)
    }

    func testReinsertingAutocompleteRemovedSpaceInsertsSingleSpaceIfAnAutoRemovedSpaceExists() {
        setupProxy("foo ", "bar")
        insertAutocompleteSuggestionWithMockAdjustments()
        proxy.tryRemoveAutocompleteInsertedSpace()
        proxy.resetCalls()
        proxy.tryReinsertAutocompleteRemovedSpace()
        let insert = proxy.calls(to: proxy.insertTextRef)
        XCTAssertEqual(insert.count, 1)
    }
}
#endif
