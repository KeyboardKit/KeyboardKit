//
//  KeyboardCallouts_ActionsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-11-03.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import Testing

class KeyboardCallouts_ActionsTests {

    @Test func testCalloutActionsCanBeCreatedWithCharacters() {
        var actions = KeyboardCallout.Actions(characters: [
            "a" : "bc",
            "d" : "ef"
        ])
        actions.actionsDictionary[.backspace] = [.capsLock]

        #expect(actions.actions(for: .char("a")) == [.char("b"), .char("c")])
        #expect(actions.actions(for: .char("b")) == nil)
        #expect(actions.actions(for: .char("d")) == [.char("e"), .char("f")])
        #expect(actions.actions(for: .backspace) == [.capsLock])
        #expect(actions.actions(for: .capsLock) == nil)
    }

    @Test func testCalloutActionsCanMatchWithCaseInsensitivity() {
        var actions = KeyboardCallout.Actions(characters: [
            "a" : "bc",
            "d" : "ef"
        ])
        actions.actionsDictionary[.backspace] = [.capsLock]

        #expect(actions.actions(for: .char("a")) == [.char("b"), .char("c")])
        #expect(actions.actions(for: .char("A")) == [.char("B"), .char("C")])
    }
}

private extension KeyboardAction {

    static func char(_ char: String) -> KeyboardAction {
        .character(char)
    }
}
