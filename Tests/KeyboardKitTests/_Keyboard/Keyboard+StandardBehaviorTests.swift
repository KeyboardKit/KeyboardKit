//
//  Keyboard+StandardBehaviorTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import CoreGraphics
import XCTest

@testable import KeyboardKit

class Keyboard_StandardBehaviorTests: XCTestCase {
    
    typealias Gesture = Keyboard.Gesture
    typealias Action = KeyboardAction

    var behavior: Keyboard.StandardBehavior!
    var keyboardContext: KeyboardContext!
    var proxy: MockTextDocumentProxy!
    var timer: GestureButtonTimer!


    override func setUp() {
        timer = .init()
        proxy = MockTextDocumentProxy()
        keyboardContext = .init()
        keyboardContext.locale = .english
        keyboardContext.sync(with: MockKeyboardInputViewController())
        keyboardContext.originalTextDocumentProxy = proxy
        behavior = .init(keyboardContext: keyboardContext, repeatGestureTimer: timer)
    }


    // MARK: - Backspace Range

    func testBackspaceRangeChangesTheLongerItIsPressed() {
        func result(after seconds: TimeInterval) -> Keyboard.BackspaceRange {
            timer.start {}
            timer.modifyStartDate(to: Date().addingTimeInterval(-seconds))
            return behavior.backspaceRange
        }
        XCTAssertEqual(result(after: 0), .character)
        XCTAssertEqual(result(after: 2.9), .character)
        XCTAssertEqual(result(after: 3.1), .word)
    }


    // MARK: - Preferred Keyboard Case

    func keyboardCase(
        for gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Keyboard.KeyboardCase {
        behavior.preferredKeyboardCase(after: gesture, on: action)
    }

    func testPreferredKeyboardCaseIsContextPreferredForAllActionsExceptShift() {
        let actions = KeyboardAction.testActions.filter { !$0.isShiftAction }
        let current = keyboardContext.keyboardCase
        let preferred = keyboardContext.preferredKeyboardCase
        XCTAssertNotEqual(preferred, current)
        actions.forEach {
            XCTAssertEqual(keyboardCase(for: .press, on: $0), preferred)
            XCTAssertEqual(keyboardCase(for: .release, on: $0), preferred)
            XCTAssertEqual(keyboardCase(for: .doubleTap, on: $0), preferred)
        }

    }

    func testPreferredKeyboardCaseIsCapsLockIfShiftIsDoubleTapped() {
        let current = keyboardContext.keyboardCase
        let preferred = keyboardContext.preferredKeyboardCase
        XCTAssertNotEqual(preferred, current)
        XCTAssertEqual(keyboardCase(for: .press, on: .shift(.auto)), current)
        behavior.lastShiftCheck = .now.addingTimeInterval(-10)
        XCTAssertEqual(keyboardCase(for: .release, on: .shift(.auto)), current)
        behavior.lastShiftCheck = .now
        XCTAssertEqual(keyboardCase(for: .release, on: .shift(.auto)), .capsLocked)
    }


    // MARK: - Preferred Keyboard Type

    func keyboardType(
        for gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Keyboard.KeyboardType {
        behavior.preferredKeyboardType(after: gesture, on: action)
    }

    func testPreferredKeyboardTypeIsByDefaultContextType() {
        keyboardContext.settings.isAutocapitalizationEnabled = true
        Keyboard.KeyboardType.allCases.forEach {
            keyboardContext.keyboardType = $0
            XCTAssertEqual(keyboardType(for: .press, on: .backspace), $0)
            XCTAssertEqual(keyboardType(for: .release, on: .character("i")), $0)
        }
    }

    func testPreferredKeyboardTypeIsAlphabeticIfNumericOrSymbolicQuotationDelimiterIsReleased() {
        Keyboard.KeyboardType.allCases.forEach {
            keyboardContext.keyboardType = $0
            let delim = KeyboardAction.character(Locale.swedish.alternateQuotationBeginDelimiter ?? "")
            let shouldSwitch = $0 == .numeric || $0 == .symbolic
            XCTAssertEqual(keyboardType(for: .press, on: delim), $0)
            XCTAssertEqual(keyboardType(for: .release, on: delim), shouldSwitch ? .alphabetic : $0)
        }
    }

    #if os(iOS) || os(tvOS) || os(visionOS)
    func testPreferredKeyboardTypeIsAlphabeticIfSingleNumericOrSymbolicSpaceIsReleased() {
        Keyboard.KeyboardType.allCases.forEach {
            keyboardContext.keyboardType = $0
            proxy.documentContextBeforeInput = "Test "
            let shouldSwitch = $0 == .numeric || $0 == .symbolic
            XCTAssertEqual(keyboardType(for: .press, on: .space), $0)
            XCTAssertEqual(keyboardType(for: .release, on: .space), shouldSwitch ? .alphabetic : $0)
        }
    }

    func testPreferredKeyboardTypeIsUnchangedIfSubsequentWhitespaceIsReleasedInSymbolicOrNumericKeyboards() {
        Keyboard.KeyboardType.allCases.forEach {
            keyboardContext.keyboardType = $0
            proxy.documentContextBeforeInput = "Test  "
            XCTAssertEqual(keyboardType(for: .press, on: .space), $0)
            XCTAssertEqual(keyboardType(for: .release, on: .space), $0)
        }
    }

    func testPreferredKeyboardTypeIsAlphabeticIfNewLineIsEnteredAfterFinishedSentence() {
        Keyboard.KeyboardType.allCases.forEach {
            keyboardContext.keyboardType = $0
            proxy.documentContextBeforeInput = "Test. "
            let shouldSwitch = $0 == .numeric || $0 == .symbolic
            XCTAssertEqual(keyboardType(for: .press, on: .primary(.done)), $0)
            XCTAssertEqual(keyboardType(for: .release, on: .primary(.continue)), shouldSwitch ? .alphabetic : $0)
        }
    }

    func testPreferredKeyboardTypeIsUnchangedIfNewLineIsEnteredAfterNonFinishedSentence() {
        Keyboard.KeyboardType.allCases.forEach {
            keyboardContext.keyboardType = $0
            proxy.documentContextBeforeInput = "Test  "
            XCTAssertEqual(keyboardType(for: .press, on: .primary(.done)), $0)
            XCTAssertEqual(keyboardType(for: .release, on: .primary(.newLine)), $0)
        }
    }
    #endif


    // MARK: - Should End Sentende

    func testShouldEndSentenceOnlyForSpaceAfterPreviousSpace() {
        func result(after gesture: Gesture, on action: Action) -> Bool {
            behavior.shouldEndCurrentSentence(after: gesture, on: action)
        }
        proxy.documentContextBeforeInput = "hej  "
        XCTAssertTrue(result(after: .release, on: .space))
        XCTAssertFalse(result(after: .release, on: .character(" ")))
        XCTAssertFalse(result(after: .release, on: .command))
        proxy.documentContextBeforeInput = "hej. "
        XCTAssertFalse(result(after: .release, on: .space))
        XCTAssertFalse(result(after: .release, on: .character(" ")))
        proxy.documentContextBeforeInput = "hej.  "
        XCTAssertFalse(result(after: .release, on: .space))
        XCTAssertFalse(result(after: .release, on: .character(" ")))
    }


    // MARK: - Should Register Emoji

    func testShouldOnlyRegisterEmojiForReleaseOnEmojiAction() {
        func result(after gesture: Gesture, on action: Action) -> Bool {
            behavior.shouldRegisterEmoji(after: gesture, on: action)
        }
        KeyboardAction.testActions.forEach { action in
            Keyboard.Gesture.allCases.forEach { gesture in
                let expected = gesture == .release && action.isEmojiAction
                XCTAssertEqual(result(after: gesture, on: action), expected)
            }
        }
    }
}
#endif
