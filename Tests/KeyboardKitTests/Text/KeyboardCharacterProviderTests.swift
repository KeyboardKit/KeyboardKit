//
//  KeyboardCharacterProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardCharacterProviderTests: XCTestCase {

    func testProvidersCanAccessCharacters() {
        XCTAssertEqual(String.carriageReturn, KeyboardCharacters.carriageReturn)
        XCTAssertEqual(String.newline, KeyboardCharacters.newline)
        XCTAssertEqual(String.space, KeyboardCharacters.space)
        XCTAssertEqual(String.tab, KeyboardCharacters.tab)
        XCTAssertEqual(String.zeroWidthSpace, KeyboardCharacters.zeroWidthSpace)
        XCTAssertEqual(String.carriageReturn, KeyboardCharacters.carriageReturn)
        XCTAssertEqual(String.newline, KeyboardCharacters.newline)
    }
}
