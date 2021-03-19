//
//  KeyboardAction_AutocompleteTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardAction_AutocompleteTests: QuickSpec {
    
    override func spec() {
        
        var actions: [KeyboardAction]!
        var delimiterActions: [KeyboardAction]!
        
        beforeEach {
            actions = KeyboardAction.testActions
            delimiterActions = String.wordDelimiters.map { .character($0) }
            delimiterActions.forEach { actions.append($0) }
        }
        
        describe("should apply autocomplete suggestion") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.shouldApplyAutocompleteSuggestion
            }
            
            it("is true for word delimiters and some other actions") {
                var expected = delimiterActions!
                expected.append(.newLine)
                expected.append(.return)
                expected.append(.space)
                actions.forEach {
                    expect(result(for: $0)).to(equal(expected.contains($0)))
                }
            }
        }
        
        describe("should remove autocomplete inserted space") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.shouldRemoveAutocompleteInsertedSpace
            }
            
            it("is true for word delimiters actions") {
                actions.forEach {
                    let expected = delimiterActions.contains($0) && !$0.isSpace
                    expect(result(for: $0)).to(equal(expected))
                }
            }
        }
    }
}
