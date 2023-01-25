//
//  UITextDocumentProxy+DeleteTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import MockingKit
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


    func deleteBackwardResult(for range: DeleteBackwardRange, _ expected: Int) -> Bool {
        proxy.resetCalls()
        proxy.deleteBackward(range: range)
        return proxy.hasCalled(\.deleteBackwardRef, numberOfTimes: expected)
    }

    func testDeleteBackwardWithCharRange() {
        proxy.documentContextBeforeInput = nil
        XCTAssertTrue(deleteBackwardResult(for: .char, 1))

        proxy.documentContextBeforeInput = "abc 123 "
        XCTAssertTrue(deleteBackwardResult(for: .char, 1))
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


    func deleteBackwardTextResult(for range: DeleteBackwardRange) -> String? {
        proxy.deleteBackwardText(for: range)
    }

    func testDeleteBackwardTextReturnsNilIfNoTextExistsBeforeInput() {
        proxy.documentContextBeforeInput = nil
        XCTAssertNil(deleteBackwardTextResult(for: .char))
        XCTAssertNil(deleteBackwardTextResult(for: .word))
        XCTAssertNil(deleteBackwardTextResult(for: .sentence))
    }

    func testDeleteBackwardTextReturnsWithCharRange() {
        proxy.documentContextBeforeInput = "abc 123 "
        XCTAssertEqual(deleteBackwardTextResult(for: .char), " ")
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
