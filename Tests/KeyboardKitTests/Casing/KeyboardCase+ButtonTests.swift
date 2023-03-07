//
//  KeyboardCase+ButtonTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI
import XCTest

class KeyboardCase_ButtonTests: XCTestCase {

    func result(for state: KeyboardCase) -> Image {
        state.standardButtonImage
    }

    func testStandardButtonImageIsDefinedForAllStates() {
        XCTAssertEqual(result(for: .auto), .keyboardShiftLowercased)
        XCTAssertEqual(result(for: .capsLocked), .keyboardShiftCapslocked)
        XCTAssertEqual(result(for: .lowercased), .keyboardShiftLowercased)
        XCTAssertEqual(result(for: .uppercased), .keyboardShiftUppercased)
    }
}
