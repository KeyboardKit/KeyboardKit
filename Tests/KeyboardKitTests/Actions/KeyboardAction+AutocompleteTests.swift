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
            
            it("is true for word and sentence ending actions") {
                var expected = delimiterActions!
                expected.append(.newLine)
                expected.append(.return)
                expected.append(.space)
                actions.forEach {
                    expect($0.shouldApplyAutocompleteSuggestion).to(equal(expected.contains($0)))
                }
            }
        }
    }
}
