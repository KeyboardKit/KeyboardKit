//
//  KeyboardCasing+ButtonTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI
import XCTest

class KeyboardCasing_ButtonTests: XCTestCase {

    func result(for state: KeyboardCasing) -> Image {
        state.standardButtonImage
    }

    func testStandardButtonImageIsDefinedForAllStates() {
        XCTAssertEqual(result(for: .auto), .keyboardShiftLowercased)
        XCTAssertEqual(result(for: .capsLocked), .keyboardShiftCapslocked)
        XCTAssertEqual(result(for: .lowercased), .keyboardShiftLowercased)
        XCTAssertEqual(result(for: .uppercased), .keyboardShiftUppercased)
    }
}
