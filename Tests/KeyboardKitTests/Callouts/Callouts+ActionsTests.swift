//
//  Callouts+ActionsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-11-03.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import Testing

class KeyboardCallouts_ActionsTests {

    @Test func testCalloutActionsCanBeCreatedWithActions() {
        var actions = Callouts.Actions(actions: [
            .backspace: [.character("a")]
        ])
        actions.actionsDictionary[.command] = [.capsLock]
        #expect(actions.actions(for: .backspace) == [.char("a")])
        #expect(actions.actions(for: .command) == [.capsLock])
        #expect(actions.actions(for: .capsLock) == nil)
    }

    @Test func testCalloutActionsCanBeCreatedWithActionsAndCharacters() {
        let actions = Callouts.Actions(
            actions: [.backspace: [.character("a")]],
            characters: ["b": "bc"]
        )
        #expect(actions.actions(for: .backspace) == [.char("a")])
        #expect(actions.actions(for: .character("b")) == [.char("b"), .char("c")])
        #expect(actions.actions(for: .character("B")) == [.char("B"), .char("C")])
        #expect(actions.actions(for: .capsLock) == nil)
    }

    @Test func testCalloutActionsCanBeCreatedWithCharacters() {
        var actions = Callouts.Actions(characters: [
            "a": "bc",
            "d": "ef"
        ])
        actions.actionsDictionary[.backspace] = [.capsLock]

        #expect(actions.actions(for: .char("a")) == [.char("b"), .char("c")])
        #expect(actions.actions(for: .char("d")) == [.char("e"), .char("f")])
        #expect(actions.actions(for: .char("A")) == [.char("B"), .char("C")])
        #expect(actions.actions(for: .char("D")) == [.char("E"), .char("F")])
        #expect(actions.actions(for: .backspace) == [.capsLock])
        #expect(actions.actions(for: .capsLock) == nil)
    }

    @Test func testBaseActionsAreCorrect() {
        let actions = Callouts.Actions.base
        #expect(actions.actions(for: .char("0")) == [.char("0"), .char("°")])
        #expect(actions.actions(for: .urlDomain)?.count == 4)
        #expect(actions.actions(for: .char("h")) == nil)
    }

    @Test func testEnglishActionsAreCorrect() {
        let actions = Callouts.Actions.english
        #expect(actions.actions(for: .char("0")) == [.char("0"), .char("°")])
        #expect(actions.actions(for: .urlDomain)?.count == 4)
        #expect(actions.actions(for: .char("h")) == [.char("h"), .char("ħ")])
    }
}

private extension KeyboardAction {

    static func char(_ char: String) -> KeyboardAction {
        .character(char)
    }
}
