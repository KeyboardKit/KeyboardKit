//
//  UITextDocumentProxy+CurrentWordTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import MockingKit
import XCTest
@testable import KeyboardKit

class UITextDocumentProxy_CurrentWordTests: XCTestCase {
    
    var proxy: MockTextDocumentProxy!

    var delimiters: [String] { return proxy.wordDelimiters }

    override func setUp() {
        proxy = MockTextDocumentProxy()
    }


    func testCurrentWordReturnsNilIfBeforeAndAfterContextIsMissing() {
        let result = proxy.currentWord
        XCTAssertNil(result)
    }

    func testCurrentWordReturnsBeforeContextIfAfterContextIsMissing() {
        proxy.documentContextBeforeInput = "this must work"
        let result = proxy.currentWord
        XCTAssertEqual(result, "work")
    }

    func testCurrentWordReturnsAfterContextIfBeforeContextIsMissing() {
        proxy.documentContextAfterInput = "work this must"
        let result = proxy.currentWord
        XCTAssertEqual(result, "work")
    }

    func testCurrentWordReturnsBeforeAndAfterContextIfBothAreSet() {
        proxy.documentContextBeforeInput = "I am cur"
        proxy.documentContextAfterInput = "rently writing stuff"
        let result = proxy.currentWord
        XCTAssertEqual(result, "currently")
    }


    func testCurrentWordPreCursorPartReturnsNilIfBeforeContextIsMissing() {
        let result = proxy.currentWordPreCursorPart
        XCTAssertNil(result)
    }

    func testCurrentWordPreCursorPartReturnsEmptyStringIfContextIsEmpty() {
        proxy.documentContextBeforeInput = ""
        let result = proxy.currentWordPreCursorPart
        XCTAssertEqual(result, "")
    }

    func testCurrentWordPreCursorPartExtractsLastWordIfNoDelimiterIsPresent() {
        let expected = "expected"
        proxy.documentContextBeforeInput = "this is expected"
        let result = proxy.currentWordPreCursorPart
        XCTAssertEqual(result, expected)
    }

    func testCurrentWordPreCursorPartStopsAtTheSpecifiedWordDelimiters() {
        let expected = "expected"
        delimiters.forEach {
            let prefix = "do not include" + $0
            let before = prefix + expected
            proxy.documentContextBeforeInput = before
            let result = proxy.currentWordPreCursorPart
            XCTAssertEqual(result, expected)
        }
    }


    func testCurrentWordPostCursorPartReturnsNilIfAfterContextIsMissing() {
        let result = proxy.currentWordPostCursorPart
        XCTAssertNil(result)
    }

    func testCurrentWordPostCursorPartReturnsEmptyStringIfContextIsEmpty() {
        proxy.documentContextAfterInput = ""
        let result = proxy.currentWordPostCursorPart
        XCTAssertEqual(result, "")
    }

    func testCurrentWordPostCursorPartExtractsLastWordIfNoDelimiterIsPresent() {
        let expected = "expected"
        proxy.documentContextAfterInput = "expected this is"
        let result = proxy.currentWordPostCursorPart
        XCTAssertEqual(result, expected)
    }

    func testCurrentWordPostCursorPartStopsAtTheSpecifiedWordDelimiters() {
        let expected = "expected"
        delimiters.forEach {
            let suffix = $0 + "do not include"
            let after = expected + suffix
            proxy.documentContextAfterInput = after
            let result = proxy.currentWordPostCursorPart
            XCTAssertEqual(result, expected)
        }
    }


    func testIsCursorAtTheEndOfTheCurrentWordReturnsFalseIfCurrentWordIsMissing() {
        let result = proxy.isCursorAtTheEndOfTheCurrentWord
        XCTAssertFalse(result)
    }

    func testIsCursorAtTheEndOfTheCurrentWordReturnsFalseIfCursorIsInTheMiddleOfWord() {
        proxy.documentContextBeforeInput = "foo"
        proxy.documentContextAfterInput = "bat"
        let result = proxy.isCursorAtTheEndOfTheCurrentWord
        XCTAssertFalse(result)
    }

    func testIsCursorAtTheEndOfTheCurrentWordReturnsFalseIfCursorIsAtTheBeginningOfWord() {
        proxy.documentContextBeforeInput = ""
        proxy.documentContextAfterInput = "Hello"
        let result = proxy.isCursorAtTheEndOfTheCurrentWord
        XCTAssertFalse(result)
    }

    func testIsCursorAtTheEndOfTheCurrentWordReturnsFalseIfCursorIsAfterWordDelimiter() {
        proxy.documentContextBeforeInput = "."
        proxy.documentContextAfterInput = "Hello"
        let result = proxy.isCursorAtTheEndOfTheCurrentWord
        XCTAssertFalse(result)
    }

    func testIsCursorAtTheEndOfTheCurrentWordReturnsTrueIfCursorIsAtTheEndOfTheCurrentWord() {
        proxy.documentContextBeforeInput = "Period"
        proxy.documentContextAfterInput = ""
        let result = proxy.isCursorAtTheEndOfTheCurrentWord
        XCTAssertTrue(result)
    }


    func testReplacingCurrentWordProceedsIfCurrentWordIsMissing() {
        proxy.replaceCurrentWord(with: "another text")
        let adjust = proxy.calls(to: \.adjustTextPositionRef)
        let delete = proxy.calls(to: \.deleteBackwardRef)
        let insert = proxy.calls(to: \.insertTextRef)
        XCTAssertEqual(adjust.count, 1)
        XCTAssertEqual(delete.count, 0)
        XCTAssertEqual(insert.count, 1)
    }


    func prepareNoPostCursorPart() {
        proxy.documentContextBeforeInput = "this is díacrïtics"
        proxy.replaceCurrentWord(with: "replacement")
    }

    func testReplacingCurrentWordWithNoPostCustorPartDoesNotAdjustTextPosition() {
        prepareNoPostCursorPart()
        let calls = proxy.calls(to: \.adjustTextPositionRef)
        XCTAssertEqual(calls.count, 1)
        XCTAssertEqual(calls[0].arguments, 0)
    }

    func testReplacingCurrentWordWithNoPostCustorPartDeletesBackwardsCurrentWordCountTimes() {
        prepareNoPostCursorPart()
        let calls = proxy.calls(to: \.deleteBackwardRef)
        XCTAssertEqual(calls.count, 10)
    }

    func testReplacingCurrentWordWithNoPostCustorPartInsertsReplacementText() {
        prepareNoPostCursorPart()
        let calls = proxy.calls(to: \.insertTextRef)
        XCTAssertEqual(calls.count, 1)
        XCTAssertEqual(calls[0].arguments, "replacement")
    }


    func prepareNoPreCursorPart() {
        proxy.documentContextAfterInput = "Objective-C is great"
        proxy.replaceCurrentWord(with: "Swift")
    }

    func testReplacingCurrentWordWithNoPrePardAdjustsTextPositionPostCursorCountTimes() {
        prepareNoPreCursorPart()
        let calls = proxy.calls(to: \.adjustTextPositionRef)
        XCTAssertEqual(calls.count, 1)
        XCTAssertEqual(calls[0].arguments, 11)
    }

    func testReplacingCurrentWordWithNoPrePartDeletesBackwardsCurrentWordCountTimes() {
        prepareNoPreCursorPart()
        let calls = proxy.calls(to: \.deleteBackwardRef)
        XCTAssertEqual(calls.count, 11)
    }

    func testReplacingCurrentWordWithNoPrePardInsertsReplacementText() {
        prepareNoPreCursorPart()
        let calls = proxy.calls(to: \.insertTextRef)
        XCTAssertEqual(calls.count, 1)
        XCTAssertEqual(calls[0].arguments, "Swift")
    }


    func preparePreAndPostCursorPart() {
        proxy.documentContextBeforeInput = "I think Obj"
        proxy.documentContextAfterInput = "ective-C is great"
        proxy.replaceCurrentWord(with: "Swift")
    }

    func testReplacingCurrentWordWithPreAndPostPartAdjustsTextPositionPostCursorCountTimes() {
        preparePreAndPostCursorPart()
        let calls = proxy.calls(to: \.adjustTextPositionRef)
        XCTAssertEqual(calls.count, 1)
        XCTAssertEqual(calls[0].arguments, 8)
    }

    func testReplacingCurrentWordWithPreAndPostPartDeletesBackwardsCurrentWordCountTimes() {
        preparePreAndPostCursorPart()
        let calls = proxy.calls(to: \.deleteBackwardRef)
        XCTAssertEqual(calls.count, 11)
    }

    func testReplacingCurrentWordWithPreAndPostPartInsertsReplacementText() {
        preparePreAndPostCursorPart()
        let calls = proxy.calls(to: \.insertTextRef)
        XCTAssertEqual(calls.count, 1)
        XCTAssertEqual(calls[0].arguments, "Swift")
    }
}
#endif
