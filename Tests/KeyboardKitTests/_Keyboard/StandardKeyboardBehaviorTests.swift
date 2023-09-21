//
//  StandardKeyboardBehaviorTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import CoreGraphics
import MockingKit
import XCTest

@testable import KeyboardKit

class StandardKeyboardBehaviorTests: XCTestCase {
    
    typealias Gesture = Gestures.KeyboardGesture
    
    var behavior: StandardKeyboardBehavior!
    var keyboardContext: KeyboardContext!
    var proxy: MockTextDocumentProxy!
    var timer: Gestures.RepeatTimer!


    override func setUp() {
        timer = Gestures.RepeatTimer.shared
        proxy = MockTextDocumentProxy()
        keyboardContext = KeyboardContext(controller: MockKeyboardInputViewController())
        keyboardContext.textDocumentProxy = proxy
        behavior = StandardKeyboardBehavior(keyboardContext: keyboardContext)
    }


    func backspaceRangeResult(after seconds: TimeInterval) -> Keyboard.BackspaceRange {
        timer.start {}
        timer.modifyStartDate(to: Date().addingTimeInterval(-seconds))
        return behavior.backspaceRange
    }

    func testBackspaceRangeIsCharBeforeThreeSecondsThenWords() {
        XCTAssertEqual(backspaceRangeResult(after: 0), .character)
        XCTAssertEqual(backspaceRangeResult(after: 2.9), .character)
        XCTAssertEqual(backspaceRangeResult(after: 3.1), .word)
    }


    func preferredKeyboardTypeResult(
        after gesture: Gesture,
        on action: KeyboardAction
    ) -> Keyboard.KeyboardType {
        behavior.preferredKeyboardType(after: gesture, on: action)
    }

    func testPreferredKeyboardTypeAfterGestureOnActionIsByDefaultContextPreferredType() {
        proxy.documentContextBeforeInput = "Hello!"
        proxy.autocapitalizationType = .allCharacters
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        let result = preferredKeyboardTypeResult(after: .release, on: .character("i"))
        XCTAssertEqual(result, .alphabetic(.uppercased))
    }

    func testPreferredKeyboardTypeAfterGestureOnActionIsByDefaultContextTypeForNonTap() {
        proxy.documentContextBeforeInput = "Hello!"
        proxy.autocapitalizationType = .allCharacters
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        let result = preferredKeyboardTypeResult(after: .press, on: .character("i"))
        XCTAssertEqual(result, keyboardContext.keyboardType)
    }

    func testPreferredKeyboardTypeAfterGestureOnActionIsContextPreferredTypeIfShiftIsDoubleTappedTooSlowly() {
        keyboardContext.keyboardType = .alphabetic(.uppercased)
        behavior.lastShiftCheck = .distantPast
        let result = preferredKeyboardTypeResult(after: .release, on: .shift(currentCasing: .uppercased))
        XCTAssertEqual(result, keyboardContext.keyboardType)
    }

    func testPreferredKeyboardTypeAfterGestureOnActionIsContextPreferredTypeIfNonShiftIsDoubleTapped() {
        keyboardContext.keyboardType = .alphabetic(.uppercased)
        let result = preferredKeyboardTypeResult(after: .release, on: .command)
        XCTAssertEqual(result, .alphabetic(.lowercased))
    }

    func testPreferredKeyboardTypeAfterGestureOnActionIsContextPreferredTypeIfCurrentTypeIsNotUpperCased() {
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        let result = preferredKeyboardTypeResult(after: .release, on: .command)
        XCTAssertEqual(result, .alphabetic(.lowercased))
    }

    func testPreferredKeyboardTypeAfterGestureOnActionIsCapsLockedIfShiftIsDoubleTappedQuicklyEnough() {
        keyboardContext.keyboardType = .alphabetic(.uppercased)
        let result = preferredKeyboardTypeResult(after: .release, on: .shift(currentCasing: .uppercased))
        XCTAssertEqual(result, .alphabetic(.capsLocked))
    }


    func shouldEndSentenceResult(
        after gesture: Gesture,
        on action: KeyboardAction
    ) -> Bool {
        behavior.shouldEndSentence(after: gesture, on: action)
    }

    func testShouldEndSentenceIsOnlyTrueForSpaceAfterPreviousSpace() {
        proxy.documentContextBeforeInput = "hej  "
        XCTAssertTrue(shouldEndSentenceResult(after: .release, on: .space))
        XCTAssertFalse(shouldEndSentenceResult(after: .release, on: .character(" ")))
        XCTAssertFalse(shouldEndSentenceResult(after: .release, on: .command))
        proxy.documentContextBeforeInput = "hej. "
        XCTAssertFalse(shouldEndSentenceResult(after: .release, on: .space))
        XCTAssertFalse(shouldEndSentenceResult(after: .release, on: .character(" ")))
        proxy.documentContextBeforeInput = "hej.  "
        XCTAssertFalse(shouldEndSentenceResult(after: .release, on: .space))
        XCTAssertFalse(shouldEndSentenceResult(after: .release, on: .character(" ")))
    }


    func shouldSwitchToCapsLockResult(
        after gesture: Gesture,
        on action: KeyboardAction
    ) -> Bool {
        behavior.shouldSwitchToCapsLock(after: gesture, on: action)
    }

    func testShouldSwitchToCapsLockIsFalseIfKeyboardTypeIsNotAlphabeticWhenActionIsDoubleTapOnShift() {
        keyboardContext.keyboardType = .numeric
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .release, on: .shift(currentCasing: .capsLocked)))
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .release, on: .shift(currentCasing: .lowercased)))
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .release, on: .shift(currentCasing: .lowercased)))
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .release, on: .shift(currentCasing: .uppercased)))
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .release, on: .shift(currentCasing: .uppercased)))
    }

    func testShouldSwitchToCapsLockIsFalseIfKeyboardTypeIsAlphabeticWhenActionIsDoubleTapOnShift() {
        XCTAssertTrue(shouldSwitchToCapsLockResult(after: .release, on: .shift(currentCasing: .capsLocked)))
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .release, on: .shift(currentCasing: .lowercased)))
        XCTAssertTrue(shouldSwitchToCapsLockResult(after: .release, on: .shift(currentCasing: .lowercased)))
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .release, on: .shift(currentCasing: .uppercased)))
        XCTAssertTrue(shouldSwitchToCapsLockResult(after: .release, on: .shift(currentCasing: .uppercased)))
    }


    func shouldSwitchToPreferredKeyboardTypeResult(
        after gesture: Gesture,
        on action: KeyboardAction
    ) -> Bool {
        behavior.shouldSwitchToPreferredKeyboardType(after: gesture, on: action)
    }

    func testShouldSwitchToPreferredKeyboardTypeIsFalseIfActionIsShift() {
        XCTAssertTrue(shouldSwitchToPreferredKeyboardTypeResult(after: .release, on: .shift(currentCasing: .capsLocked)))
        XCTAssertTrue(shouldSwitchToPreferredKeyboardTypeResult(after: .release, on: .shift(currentCasing: .lowercased)))
        XCTAssertTrue(shouldSwitchToPreferredKeyboardTypeResult(after: .release, on: .shift(currentCasing: .uppercased)))
    }

    func testShouldSwitchToPreferredKeyboardTypeIsFalseForMostKeyboardTypes() {
        let types: [Keyboard.KeyboardType] = [
            .custom(named: "foo"),
            .email,
            .emojis,
            .images,
            .numeric,
            .symbolic]
        types.forEach {
            XCTAssertFalse(shouldSwitchToPreferredKeyboardTypeResult(after: .release, on: .keyboardType($0)))
        }
    }

    func testShouldSwitchToPreferredKeyboardTypeIsOnlyTrueForAlphabeticAutoCasedKeyboardType() {
        let expectedTrue: [Keyboard.KeyboardType] = [
            .alphabetic(.auto)]
        let expectedFalse: [Keyboard.KeyboardType] = [
            .alphabetic(.capsLocked),
            .alphabetic(.lowercased),
            .alphabetic(.uppercased)]
        expectedTrue.forEach {
            XCTAssertTrue(shouldSwitchToPreferredKeyboardTypeResult(after: .release, on: .keyboardType($0)))
        }
        expectedFalse.forEach {
            XCTAssertFalse(shouldSwitchToPreferredKeyboardTypeResult(after: .release, on: .keyboardType($0)))
        }
    }

    func testShouldSwitchToPreferredKeyboardTypeIsFalseIfActionIsKeyboardType() {
        let types: [Keyboard.KeyboardType] = [
            .alphabetic(.lowercased),
            .custom(named: "foo"),
            .email,
            .emojis,
            .images,
            .numeric,
            .symbolic]
        types.forEach {
            XCTAssertFalse(shouldSwitchToPreferredKeyboardTypeResult(after: .release, on: .keyboardType($0)))
        }
    }

    func testShouldSwitchToPreferredKeyboardTypeIsTrueIfCurrentKeyboardTypeDiffersFromPreferredOne() {
        proxy.documentContextBeforeInput = "Hello!"
        proxy.autocapitalizationType = .allCharacters
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        XCTAssertTrue(shouldSwitchToPreferredKeyboardTypeResult(after: .release, on: .character("i")))
    }

    func testShouldSwitchToPreferredKeyboardTypeIsFalseIfCurrentKeyboardIsTheSameAsThePrefferredOneWithoutAutocap() {
        proxy.documentContextBeforeInput = "Hello!"
        proxy.autocapitalizationType = .none
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        XCTAssertFalse(shouldSwitchToPreferredKeyboardTypeResult(after: .release, on: .character("i")))
    }

    func testShouldSwitchToPreferredKeyboardTypeIsFalseIfCurrentKeyboardIsTheSameAsThePrefferredOne() {
        proxy.documentContextBeforeInput = "Hello. "
        keyboardContext.keyboardType = .symbolic
        XCTAssertFalse(shouldSwitchToPreferredKeyboardTypeResult(after: .release, on: .keyboardType(.numeric)))
    }


    func shouldSwitchToPreferredKeyboardTypeAfterTextDidChangeResult() -> Bool {
        behavior.shouldSwitchToPreferredKeyboardTypeAfterTextDidChange()
    }

    func testShouldSwitchToPreferredKeyboardTypeAfterTextDidChangeIsTrueIfCurrentKeyboardTypeIsNotPreferredOne() {
        proxy.autocapitalizationType = .sentences
        proxy.documentContextBeforeInput = "foo. "
        XCTAssertTrue(shouldSwitchToPreferredKeyboardTypeAfterTextDidChangeResult())
    }

    func testShouldSwitchToPreferredKeyboardTypeAfterTextDidChangeIsFakseIfCurrentKeyboardTyopeIsPreferredOne() {
        proxy.autocapitalizationType = .sentences
        proxy.documentContextBeforeInput = "foo. "
        keyboardContext.keyboardType = .alphabetic(.uppercased)
        XCTAssertFalse(shouldSwitchToPreferredKeyboardTypeAfterTextDidChangeResult())
    }
}
#endif
