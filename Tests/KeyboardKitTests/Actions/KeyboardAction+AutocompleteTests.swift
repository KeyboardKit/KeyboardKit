//
//  KeyboardAction_AutocompleteTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardAction_AutocompleteTests: XCTestCase {

    let actions: [KeyboardAction] = {
        var actions = KeyboardAction.testActions
        var delimiters = String.wordDelimiters.map { KeyboardAction.character($0) }
        delimiters.forEach {
            actions.append($0)
        }
        return actions
    }()

    func testShouldApplyAutocompleteSuggestionsForSomeActions() {
        actions.forEach {
            var expected = false
            switch $0 {
            case .character(let char): expected = char.isWordDelimiter
            case .newLine, .return, .space: expected = true
            case .primary(.newLine), .primary(.return): expected = true
            default: expected = false
            }
            XCTAssertEqual($0.shouldApplyAutocompleteSuggestion, expected)
        }
    }

    func testShouldReinsertAutocompleteInsertedSpaceForWordDelimiters() {
        actions.forEach {
            var expected = false
            switch $0 {
            case .character(let char): expected = char.isWordDelimiter
            default: expected = false
            }
            XCTAssertEqual($0.shouldReinsertAutocompleteInsertedSpace, expected)
        }
    }

    func testShouldRemoveAutocompleteInsertedSpaceForWordDelimiters() {
        actions.forEach {
            var expected = false
            switch $0 {
            case .character(let char): expected = char.isWordDelimiter
            default: expected = false
            }
            XCTAssertEqual($0.shouldRemoveAutocompleteInsertedSpace, expected)
        }
    }
}
