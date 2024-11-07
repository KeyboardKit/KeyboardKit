//
//  String+AutocorrectTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-24.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class String_AutocorrectTests: XCTestCase {

    func testStringDefinesTriggers() {
        let delimiters = String.autocorrectTriggers.joined()
        let expectedPrefix = ".,:;!¡?¿{}<>«»"
        XCTAssertTrue(delimiters.hasPrefix(expectedPrefix))
    }

    func testStringCanIdentifyAsTrigger() {
        let result = String.autocorrectTriggers.map { $0.isAutocorrectTrigger }
        XCTAssertTrue(result.allSatisfy { $0 })
        XCTAssertFalse("a".isAutocorrectTrigger)
    }
}
