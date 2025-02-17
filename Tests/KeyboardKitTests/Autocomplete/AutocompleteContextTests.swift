//
//  AutocompleteContextTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-26.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class AutocompleteContextTests: XCTestCase {

    let context = AutocompleteContext()
    
    func testCanBeUpdatedWithAutocompleteServiceResult() async {
        context.isLoading = true
        let result = Autocomplete.ServiceResult(
            inputText: "foo",
            suggestions: .preview,
            emojiSuggestions: [.init(text: "😊", type: .emoji)],
            nextCharacterPredictions: ["a" : 0.5]
        )
        context.update(with: result)

        await MainActor.run {
            XCTAssertEqual(context.isLoading, false)
            XCTAssertNil(context.lastError)
            XCTAssertEqual(context.suggestionsFromService, .preview)
            XCTAssertEqual(context.emojiSuggestions, [.init(text: "😊", type: .emoji)])
            XCTAssertEqual(context.nextCharacterPredictions, ["a": 0.5])
        }
    }
    
    func testCanGetNextCharacterProbabilityForStringsAndActions() {
        context.nextCharacterPredictions = [
            "a": 0.1,
            "b": 0.2
        ]

        XCTAssertEqual(context.nextCharacterPrediction(for: "a"), 0.1)
        XCTAssertEqual(context.nextCharacterPrediction(for: "b"), 0.2)
        XCTAssertEqual(context.nextCharacterPrediction(for: "c"), 0.0)
        XCTAssertEqual(context.nextCharacterPrediction(for: .character("a")), 0.1)
        XCTAssertEqual(context.nextCharacterPrediction(for: .backspace), 0)
    }
}
