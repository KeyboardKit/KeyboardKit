//
//  Keyboard+LayoutTypeTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-02-08.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI
import XCTest

class Keyboard_LayoutTypeTests: XCTestCase {

    func displayName(for type: Keyboard.LayoutType) -> String {
        type.displayName
    }

    func testDisplayNameIsValidForAllTypes() {
        XCTAssertEqual(displayName(for: .azerty), "AZERTY")
        XCTAssertEqual(displayName(for: .colemak), "Colemak")
        XCTAssertEqual(displayName(for: .qwerty), "QWERTY")
        XCTAssertEqual(displayName(for: .qwerty_catalan), "QWERTY - Catalan")
        XCTAssertEqual(displayName(for: .qwertz), "QWERTZ")
    }
}
