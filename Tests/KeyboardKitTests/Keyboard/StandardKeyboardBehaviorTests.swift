//
//  StandardKeyboardBehaviorTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import CoreGraphics
import MockingKit
import XCTest

@testable import KeyboardKit

class StandardKeyboardBehaviorTests: XCTestCase {
    
    var behavior: StandardKeyboardBehavior!
    var keyboardContext: KeyboardContext!
    var proxy: MockTextDocumentProxy!
    var timer: RepeatGestureTimer!


    override func setUp() {
        timer = RepeatGestureTimer.shared
        proxy = MockTextDocumentProxy()
        keyboardContext = KeyboardContext(controller: MockKeyboardInputViewController())
        keyboardContext.textDocumentProxy = proxy
        behavior = StandardKeyboardBehavior(keyboardContext: keyboardContext)
    }


    func backspaceRangeResult(after seconds: TimeInterval) -> DeleteBackwardRange {
        timer.start {}
        timer.modifyStartDate(to: Date().addingTimeInterval(-seconds))
        return behavior.backspaceRange
    }

    func testBackspaceRangeIsCharBeforeThreeSecondsThenWords() {
        XCTAssertEqual(backspaceRangeResult(after: 0), .char)
        XCTAssertEqual(backspaceRangeResult(after: 2.9), .char)
        XCTAssertEqual(backspaceRangeResult(after: 3.1), .word)
    }


    func preferredKeyboardTypeResult(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> KeyboardType {
        behavior.preferredKeyboardType(after: gesture, on: action)
    }

    func testPreferredKeyboardTypeAfterGestureOnActionIsByDefaultContextPreferredType() {
        proxy.documentContextBeforeInput = "Hello!"
        proxy.autocapitalizationType = .allCharacters
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        let result = preferredKeyboardTypeResult(after: .tap, on: .character("i"))
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
        let result = preferredKeyboardTypeResult(after: .tap, on: .shift(currentState: .uppercased))
        XCTAssertEqual(result, keyboardContext.keyboardType)
    }

    func testPreferredKeyboardTypeAfterGestureOnActionIsContextPreferredTypeIfNonShiftIsDoubleTapped() {
        keyboardContext.keyboardType = .alphabetic(.uppercased)
        let result = preferredKeyboardTypeResult(after: .tap, on: .command)
        XCTAssertEqual(result, .alphabetic(.lowercased))
    }

    func testPreferredKeyboardTypeAfterGestureOnActionIsContextPreferredTypeIfCurrentTypeIsNotUpperCased() {
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        let result = preferredKeyboardTypeResult(after: .tap, on: .command)
        XCTAssertEqual(result, .alphabetic(.lowercased))
    }

    func testPreferredKeyboardTypeAfterGestureOnActionIsCapsLockedIfShiftIsDoubleTappedQuicklyEnough() {
        keyboardContext.keyboardType = .alphabetic(.uppercased)
        let result = preferredKeyboardTypeResult(after: .tap, on: .shift(currentState: .uppercased))
        XCTAssertEqual(result, .alphabetic(.capsLocked))
    }


    func shouldEndSentenceResult(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool {
        behavior.shouldEndSentence(after: gesture, on: action)
    }

    func testShouldEndSentenceIsOnlyTrueForSpaceAfterPreviousSpace() {
        proxy.documentContextBeforeInput = "hej  "
        XCTAssertTrue(shouldEndSentenceResult(after: .tap, on: .space))
        XCTAssertFalse(shouldEndSentenceResult(after: .tap, on: .character(" ")))
        XCTAssertFalse(shouldEndSentenceResult(after: .tap, on: .command))
        proxy.documentContextBeforeInput = "hej. "
        XCTAssertFalse(shouldEndSentenceResult(after: .tap, on: .space))
        XCTAssertFalse(shouldEndSentenceResult(after: .tap, on: .character(" ")))
        proxy.documentContextBeforeInput = "hej.  "
        XCTAssertFalse(shouldEndSentenceResult(after: .tap, on: .space))
        XCTAssertFalse(shouldEndSentenceResult(after: .tap, on: .character(" ")))
    }


    func shouldSwitchToCapsLockResult(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool {
        behavior.shouldSwitchToCapsLock(after: gesture, on: action)
    }

    func testShouldSwitchToCapsLockIsFalseIfKeyboardTypeIsNotAlphabeticWhenActionIsDoubleTapOnShift() {
        keyboardContext.keyboardType = .numeric
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .tap, on: .shift(currentState: .capsLocked)))
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .tap, on: .shift(currentState: .lowercased)))
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .tap, on: .shift(currentState: .lowercased)))
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .tap, on: .shift(currentState: .uppercased)))
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .tap, on: .shift(currentState: .uppercased)))
    }

    func testShouldSwitchToCapsLockIsFalseIfKeyboardTypeIsAlphabeticWhenActionIsDoubleTapOnShift() {
        XCTAssertTrue(shouldSwitchToCapsLockResult(after: .tap, on: .shift(currentState: .capsLocked)))
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .tap, on: .shift(currentState: .lowercased)))
        XCTAssertTrue(shouldSwitchToCapsLockResult(after: .tap, on: .shift(currentState: .lowercased)))
        XCTAssertFalse(shouldSwitchToCapsLockResult(after: .tap, on: .shift(currentState: .uppercased)))
        XCTAssertTrue(shouldSwitchToCapsLockResult(after: .tap, on: .shift(currentState: .uppercased)))
    }


    func shouldSwitchToPreferredKeyboardTypeResult(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool {
        behavior.shouldSwitchToPreferredKeyboardType(after: gesture, on: action)
    }

    func testShouldSwitchToPreferredKeyboardTypeIsFalseIfActionIsShift() {
        XCTAssertTrue(shouldSwitchToPreferredKeyboardTypeResult(after: .tap, on: .shift(currentState: .capsLocked)))
        XCTAssertTrue(shouldSwitchToPreferredKeyboardTypeResult(after: .tap, on: .shift(currentState: .lowercased)))
        XCTAssertTrue(shouldSwitchToPreferredKeyboardTypeResult(after: .tap, on: .shift(currentState: .uppercased)))
    }

    func testShouldSwitchToPreferredKeyboardTypeIsFalseForMostKeyboardTypes() {
        let types: [KeyboardType] = [
            .custom(named: "foo"),
            .email,
            .emojis,
            .images,
            .numeric,
            .symbolic]
        types.forEach {
            XCTAssertFalse(shouldSwitchToPreferredKeyboardTypeResult(after: .tap, on: .keyboardType($0)))
        }
    }

    func testShouldSwitchToPreferredKeyboardTypeIsOnlyTrueForAlphabeticAutoCasedKeyboardType() {
        let expectedTrue: [KeyboardType] = [
            .alphabetic(.auto)]
        let expectedFalse: [KeyboardType] = [
            .alphabetic(.capsLocked),
            .alphabetic(.lowercased),
            .alphabetic(.uppercased)]
        expectedTrue.forEach {
            XCTAssertTrue(shouldSwitchToPreferredKeyboardTypeResult(after: .tap, on: .keyboardType($0)))
        }
        expectedFalse.forEach {
            XCTAssertFalse(shouldSwitchToPreferredKeyboardTypeResult(after: .tap, on: .keyboardType($0)))
        }
    }

    func testShouldSwitchToPreferredKeyboardTypeIsFalseIfActionIsKeyboardType() {
        let types: [KeyboardType] = [
            .alphabetic(.lowercased),
            .custom(named: "foo"),
            .email,
            .emojis,
            .images,
            .numeric,
            .symbolic]
        types.forEach {
            XCTAssertFalse(shouldSwitchToPreferredKeyboardTypeResult(after: .tap, on: .keyboardType($0)))
        }
    }

    func testShouldSwitchToPreferredKeyboardTypeIsTrueIfCurrentKeyboardTypeDiffersFromPreferredOne() {
        proxy.documentContextBeforeInput = "Hello!"
        proxy.autocapitalizationType = .allCharacters
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        XCTAssertTrue(shouldSwitchToPreferredKeyboardTypeResult(after: .tap, on: .character("i")))
    }

    func testShouldSwitchToPreferredKeyboardTypeIsFalseIfCurrentKeyboardIsTheSameAsThePrefferredOneWithoutAutocap() {
        proxy.documentContextBeforeInput = "Hello!"
        proxy.autocapitalizationType = .none
        keyboardContext.keyboardType = .alphabetic(.lowercased)
        XCTAssertFalse(shouldSwitchToPreferredKeyboardTypeResult(after: .tap, on: .character("i")))
    }

    func testShouldSwitchToPreferredKeyboardTypeIsFalseIfCurrentKeyboardIsTheSameAsThePrefferredOne() {
        proxy.documentContextBeforeInput = "Hello. "
        keyboardContext.keyboardType = .symbolic
        XCTAssertFalse(shouldSwitchToPreferredKeyboardTypeResult(after: .tap, on: .keyboardType(.numeric)))
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
