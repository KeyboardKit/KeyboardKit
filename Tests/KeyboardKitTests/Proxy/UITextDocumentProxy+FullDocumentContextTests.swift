//
//  UITextDocumentProxy+FullDocumentContextTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-10-01.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import XCTest

class UITextDocumentProxy_FullDocumentContextTests: XCTestCase {

    override func setUp() {
        getProxy().isReadingFullDocumentContext = false
    }

    func getProxy() -> UITextDocumentProxy {
        KeyboardInputViewController().textDocumentProxy
    }

    func result(for proxy: UITextDocumentProxy) -> Bool {
        proxy.isReadingFullDocumentContext
    }

    func testProxiesShareFullDocumentContextState() {
        let proxy1 = getProxy()
        let proxy2 = getProxy()
        XCTAssertFalse(result(for: proxy1))
        XCTAssertFalse(result(for: proxy2))
        proxy1.isReadingFullDocumentContext = true
        XCTAssertTrue(result(for: proxy1))
        XCTAssertTrue(result(for: proxy2))
        proxy1.isReadingFullDocumentContext = false
        XCTAssertFalse(result(for: proxy1))
        XCTAssertFalse(result(for: proxy2))
    }
}
#endif
