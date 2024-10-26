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


    // MARK: - Preferred Keyboard Type

    func testPreferredKeyboardTypeIsByDefaultContextType() {
        proxy.documentContextBeforeInput = "Hello!"
        proxy.autocapitalizationType = .allCharacters
        keyboardContext.settings.isAutocapitalizationEnabled = true
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        let result = behavior.preferredKeyboardType(after: .release, on: .character("i"))
        XCTAssertEqual(keyboardContext.locale, .english)
        XCTAssertEqual(result, .alphabetic(.uppercased))
    }

    func testPreferredKeyboardTypeIsByDefaultContextTypeForNonTap() {
        proxy.documentContextBeforeInput = "Hello!"
        proxy.autocapitalizationType = .allCharacters
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        let result = behavior.preferredKeyboardType(after: .press, on: .character("i"))
        XCTAssertEqual(result, keyboardContext.keyboardType)
    }

    func testPreferredKeyboardTypeIsContextTypeIfShiftIsDoubleTappedSlowly() {
        keyboardContext.keyboardType = .alphabetic(.uppercased)
        behavior.lastShiftCheck = .distantPast
        let shift = KeyboardAction.shift(currentCasing: .uppercased)
        let result = behavior.preferredKeyboardType(after: .release, on: shift)
        XCTAssertEqual(result, keyboardContext.keyboardType)
    }

    func testPreferredKeyboardTypeIsCapsLockIfShiftIsDoubleTappedQuickly() {
        keyboardContext.keyboardType = .alphabetic(.uppercased)
        let shift = KeyboardAction.shift(currentCasing: .uppercased)
        let result = behavior.preferredKeyboardType(after: .release, on: shift)
        XCTAssertEqual(result, .alphabetic(.capsLocked))
    }

    func testPreferredKeyboardTypeIsContextTypeIfNonShiftIsDoubleTapped() {
        keyboardContext.keyboardType = .alphabetic(.uppercased)
        let result = behavior.preferredKeyboardType(after: .release, on: .command)
        XCTAssertEqual(result, .alphabetic(.lowercased))
    }

    func testPreferredKeyboardTypeIsContextTypeIfCurrentTypeIsNotUpperCased() {
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        let result = behavior.preferredKeyboardType(after: .release, on: .command)
        XCTAssertEqual(result, .alphabetic(.lowercased))
    }


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


    // MARK: - Should Switch to Casp Lock

    func testShouldNotSwitchToCapsLockForNonAlphabeticTypes() {
        func result(after gesture: Gesture, on action: Action) -> Bool {
            behavior.shouldSwitchToCapsLock(after: gesture, on: action)
        }
        keyboardContext.keyboardType = .numeric
        XCTAssertFalse(result(after: .release, on: .shift(currentCasing: .capsLocked)))
        XCTAssertFalse(result(after: .release, on: .shift(currentCasing: .lowercased)))
        XCTAssertFalse(result(after: .release, on: .shift(currentCasing: .lowercased)))
        XCTAssertFalse(result(after: .release, on: .shift(currentCasing: .uppercased)))
        XCTAssertFalse(result(after: .release, on: .shift(currentCasing: .uppercased)))
    }

    func testShouldSwitchToCapsLockForAlphabeticTypesWhenActionIsDoubleTapOnShift() {
        func result(after gesture: Gesture, on action: Action) -> Bool {
            behavior.shouldSwitchToCapsLock(after: gesture, on: action)
        }
        XCTAssertTrue(result(after: .release, on: .shift(currentCasing: .capsLocked)))
        XCTAssertFalse(result(after: .release, on: .shift(currentCasing: .lowercased)))
        XCTAssertTrue(result(after: .release, on: .shift(currentCasing: .lowercased)))
        XCTAssertFalse(result(after: .release, on: .shift(currentCasing: .uppercased)))
        XCTAssertTrue(result(after: .release, on: .shift(currentCasing: .uppercased)))
    }


    // MARK: - Should Switch to Preferred Keyboard Type

    func testShouldNotSwitchToPreferredKeyboardTypeForShift() {
        func result(after gesture: Gesture, on action: Action) -> Bool {
            behavior.shouldSwitchToPreferredKeyboardType(after: gesture, on: action)
        }
        XCTAssertTrue(result(after: .release, on: .shift(currentCasing: .capsLocked)))
        XCTAssertTrue(result(after: .release, on: .shift(currentCasing: .lowercased)))
        XCTAssertTrue(result(after: .release, on: .shift(currentCasing: .uppercased)))
    }

    func testShouldNotSwitchToPreferredKeyboardTypeForMostKeyboardTypes() {
        func result(after gesture: Gesture, on action: Action) -> Bool {
            behavior.shouldSwitchToPreferredKeyboardType(after: gesture, on: action)
        }
        let types: [Keyboard.KeyboardType] = [
            .custom(named: "foo"),
            .email,
            .emojis,
            .images,
            .numeric,
            .symbolic]
        types.forEach {
            XCTAssertFalse(result(after: .press, on: .keyboardType($0)))
            XCTAssertFalse(result(after: .release, on: .keyboardType($0)))
        }
    }

    func testShouldSwitchToPreferredKeyboardTypeForAlphabeticAutoCased() {
        func result(after gesture: Gesture, on action: Action) -> Bool {
            behavior.shouldSwitchToPreferredKeyboardType(after: gesture, on: action)
        }
        let expectedTrue: [Keyboard.KeyboardType] = [
            .alphabetic(.auto)]
        let expectedFalse: [Keyboard.KeyboardType] = [
            .alphabetic(.capsLocked),
            .alphabetic(.lowercased),
            .alphabetic(.uppercased)]
        expectedTrue.forEach {
            XCTAssertTrue(result(after: .release, on: .keyboardType($0)))
        }
        expectedFalse.forEach {
            XCTAssertFalse(result(after: .release, on: .keyboardType($0)))
        }
    }

    func testShouldNotSwitchToPreferredKeyboardTypeForKeyboardTypeAction() {
        func result(after gesture: Gesture, on action: Action) -> Bool {
            behavior.shouldSwitchToPreferredKeyboardType(after: gesture, on: action)
        }
        let types: [Keyboard.KeyboardType] = [
            .alphabetic(.lowercased),
            .custom(named: "foo"),
            .email,
            .emojis,
            .images,
            .numeric,
            .symbolic]
        types.forEach {
            XCTAssertFalse(result(after: .press, on: .keyboardType($0)))
            XCTAssertFalse(result(after: .release, on: .keyboardType($0)))
        }
    }

    func testShouldSwitchToPreferredKeyboardTypeIfCurrentAndPreferredKeyboardTypeDiffers() {
        proxy.documentContextBeforeInput = "Hello!"
        proxy.autocapitalizationType = .allCharacters
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        XCTAssertTrue(behavior.shouldSwitchToPreferredKeyboardType(after: .release, on: .character("i")))
    }

    func testShouldNotSwitchToPreferredKeyboardTypeIfCurrentAndPreferredKeyboardTypeAreSameWithoutAutocap() {
        proxy.documentContextBeforeInput = "Hello!"
        proxy.autocapitalizationType = .none
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        XCTAssertFalse(behavior.shouldSwitchToPreferredKeyboardType(after: .release, on: .character("i")))
    }

    func testShouldNotSwitchToPreferredKeyboardTypeIfCurrentKeyboardIsTheSameAsThePrefferredOne() {
        proxy.documentContextBeforeInput = "Hello. "
        keyboardContext.keyboardType = .symbolic
        XCTAssertFalse(behavior.shouldSwitchToPreferredKeyboardType(after: .release, on: .keyboardType(.numeric)))
    }


    // MARK: - Should Switch To preferred After Text Did Change

    func testShouldSwitchToPreferredKeyboardTypeAfterTextDidChangeIsTrueIfCurrentKeyboardTypeIsNotPreferredOne() {
        proxy.autocapitalizationType = .sentences
        proxy.documentContextBeforeInput = "foo. "
        XCTAssertTrue(behavior.shouldSwitchToPreferredKeyboardTypeAfterTextDidChange())
    }

    func testShouldSwitchToPreferredKeyboardTypeAfterTextDidChangeIsFakseIfCurrentKeyboardTyopeIsPreferredOne() {
        proxy.autocapitalizationType = .sentences
        proxy.documentContextBeforeInput = "foo. "
        keyboardContext.keyboardType = .alphabetic(.uppercased)
        XCTAssertFalse(behavior.shouldSwitchToPreferredKeyboardTypeAfterTextDidChange())
    }
}
#endif
