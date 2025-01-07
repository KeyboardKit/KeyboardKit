//
//  UITextDocumentProxy+AutocompleteTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import XCTest

class UITextDocumentProxy_AutocompleteTests: XCTestCase {

    var proxy: MockTextDocumentProxy!

    let word = "REPLACE"
    var suggestion: Autocomplete.Suggestion!

    override func setUp() {
        proxy = MockTextDocumentProxy()
        suggestion = .init(text: word)
    }

    func setupProxy(_ before: String, _ after: String) {
        proxy.documentContextBeforeInput = before
        proxy.documentContextAfterInput = after
    }

    func applyAutocompleteWithMockAdjustments() {
        proxy.insertAutocompleteSuggestion(suggestion)
        if proxy.hasCalled(\.insertTextRef, numberOfTimes: 2) {
            proxy.documentContextBeforeInput = " "
        }
    }


    func testAutocompleteInsertsWordAndSpaceInEmptyProxy() {
        proxy.documentContextBeforeInput = ""
        applyAutocompleteWithMockAdjustments()
        let delete = proxy.calls(to: \.deleteBackwardRef)
        let insert = proxy.calls(to: \.insertTextRef)
        XCTAssertTrue(proxy.hasAutocompleteInsertedSpace)
        XCTAssertEqual(delete.count, 0)
        XCTAssertEqual(insert.count, 2)
        XCTAssertEqual(insert[0].arguments, word)
        XCTAssertEqual(insert[1].arguments, " ")
    }

    func testAutocompleteReplacesPrecursorWordAndInsertsSpaceWhenCursorIsWithinWord() {
        setupProxy("foo", "bar")
        applyAutocompleteWithMockAdjustments()
        let delete = proxy.calls(to: \.deleteBackwardRef)
        let insert = proxy.calls(to: \.insertTextRef)
        XCTAssertTrue(proxy.hasAutocompleteInsertedSpace)
        XCTAssertEqual(delete.count, 3)
        XCTAssertEqual(insert.count, 2)
        XCTAssertEqual(insert[0].arguments, word)
        XCTAssertEqual(insert[1].arguments, " ")
    }

    func testAutocompleteInsertsOnlyWordWhenInputHasTrailingSpace() {
        setupProxy("foo", " bar")
        applyAutocompleteWithMockAdjustments()
        let delete = proxy.calls(to: \.deleteBackwardRef)
        let insert = proxy.calls(to: \.insertTextRef)
        XCTAssertFalse(proxy.hasAutocompleteInsertedSpace)
        XCTAssertEqual(delete.count, 3)
        XCTAssertEqual(insert.count, 1)
        XCTAssertEqual(insert[0].arguments, word)
    }

    func testAutocompleteOnlyInsertsWordIfInsertSpaceIsExplicitlyDisabled() {
        setupProxy("foo", "bar")
        proxy.insertAutocompleteSuggestion(suggestion, tryInsertSpace: false)
        let delete = proxy.calls(to: \.deleteBackwardRef)
        let insert = proxy.calls(to: \.insertTextRef)
        XCTAssertEqual(delete.count, 3)
        XCTAssertEqual(insert.count, 1)
        XCTAssertEqual(insert[0].arguments, word)
    }

    func testRemovingAutocompleteInsertedSpaceDoesNotDoAnythingIfNoAutoInsertedSpaceExists() {
        setupProxy("foo ", "bar")
        proxy.insertAutocompleteSuggestion(suggestion, tryInsertSpace: false)
        proxy.resetCalls()
        proxy.tryRemoveAutocompleteInsertedSpace()
        let delete = proxy.calls(to: \.deleteBackwardRef)
        XCTAssertEqual(delete.count, 0)
    }

    func testRemovingAutocompleteInsertedSpaceBackspacesOnceIfAnAutoInsertedSpaceExists() {
        setupProxy("foo", "bar")
        applyAutocompleteWithMockAdjustments()
        proxy.resetCalls()
        proxy.tryRemoveAutocompleteInsertedSpace()
        let delete = proxy.calls(to: \.deleteBackwardRef)
        XCTAssertEqual(delete.count, 1)
    }


    func testReinsertingAutocompleteRemovedSpaceDoesNotDoAnythingIfNoAutoRemovedSpaceExists() {
        setupProxy("foo ", "bar")
        applyAutocompleteWithMockAdjustments()
        proxy.resetCalls()
        proxy.tryReinsertAutocompleteRemovedSpace()
        let insert = proxy.calls(to: \.insertTextRef)
        XCTAssertEqual(insert.count, 0)
    }
}
#endif
