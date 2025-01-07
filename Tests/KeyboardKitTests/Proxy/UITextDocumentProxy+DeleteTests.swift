//
//  UITextDocumentProxy+DeleteTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import XCTest

@testable import KeyboardKit

class UITextDocumentProxy_DeleteTests: XCTestCase {

    var proxy: MockTextDocumentProxy!

    var delimiters: [String] { return proxy.wordDelimiters }

    override func setUp() {
        proxy = MockTextDocumentProxy()
    }


    func testDeletingBackwardsCertainNumberOfTimes() {
        proxy.deleteBackward(times: 11)
        let delete = proxy.calls(to: \.deleteBackwardRef)
        XCTAssertEqual(delete.count, 11)
    }


    func deleteBackwardResult(for range: Keyboard.BackspaceRange, _ expected: Int) -> Bool {
        proxy.resetCalls()
        proxy.deleteBackward(range: range)
        return proxy.hasCalled(\.deleteBackwardRef, numberOfTimes: expected)
    }

    func testDeleteBackwardWithCharacterRange() {
        proxy.documentContextBeforeInput = nil
        XCTAssertTrue(deleteBackwardResult(for: .character, 1))

        proxy.documentContextBeforeInput = "abc 123 "
        XCTAssertTrue(deleteBackwardResult(for: .character, 1))
    }

    func testDeleteBackwardWithWordRange() {
        proxy.documentContextBeforeInput = nil
        XCTAssertTrue(deleteBackwardResult(for: .word, 1))

        proxy.documentContextBeforeInput = "abc "
        XCTAssertTrue(deleteBackwardResult(for: .word, 4))

        proxy.documentContextBeforeInput = "abc 123 "
        XCTAssertTrue(deleteBackwardResult(for: .word, 4))
    }

    func testDeleteBackwardWithSentenceRange() {
        proxy.documentContextBeforeInput = nil
        XCTAssertTrue(deleteBackwardResult(for: .sentence, 1))

        proxy.documentContextBeforeInput = "abc 123. "
        XCTAssertTrue(deleteBackwardResult(for: .sentence, 9))

        proxy.documentContextBeforeInput = "foo bar! abc 123. "
        XCTAssertTrue(deleteBackwardResult(for: .sentence, 10))
    }


    func deleteBackwardTextResult(for range: Keyboard.BackspaceRange) -> String? {
        proxy.deleteBackwardText(for: range)
    }

    func testDeleteBackwardTextReturnsNilIfNoTextExistsBeforeInput() {
        proxy.documentContextBeforeInput = nil
        XCTAssertNil(deleteBackwardTextResult(for: .character))
        XCTAssertNil(deleteBackwardTextResult(for: .word))
        XCTAssertNil(deleteBackwardTextResult(for: .sentence))
    }

    func testDeleteBackwardTextReturnsCharacterRange() {
        proxy.documentContextBeforeInput = "abc 123 "
        XCTAssertEqual(deleteBackwardTextResult(for: .character), " ")
    }

    func testDeleteBackwardTextReturnsWordRange() {
        proxy.documentContextBeforeInput = "abc "
        XCTAssertEqual(deleteBackwardTextResult(for: .word), "abc ")

        proxy.documentContextBeforeInput = "abc 123 "
        XCTAssertEqual(deleteBackwardTextResult(for: .word), "123 ")
    }

    func testDeleteBackwardTextReturnsSentenceRange() {
        proxy.documentContextBeforeInput = "abc 123. "
        XCTAssertEqual(deleteBackwardTextResult(for: .sentence), "abc 123. ")

        proxy.documentContextBeforeInput = "foo bar! abc 123. "
        XCTAssertEqual(deleteBackwardTextResult(for: .sentence), " abc 123. ")
    }
}
#endif
