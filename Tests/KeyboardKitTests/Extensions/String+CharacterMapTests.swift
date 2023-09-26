//
//  String+CharacterMap.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-12-31.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class String_CharsTests: XCTestCase {
    
    func testCharsSplitsStringIntoIndividualCharacters() {
        let string = "foo"
        let result = string.chars
        XCTAssertEqual(result, ["f", "o", "o"])
    }
}
