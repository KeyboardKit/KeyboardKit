//
//  KeyboardSettingsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-02.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

final class KeyboardSettingsTests: XCTestCase {

    func testHasValidDefaultPrefix() {
        let prefix = KeyboardSettings.prefix
        XCTAssertEqual(prefix, "com.keyboardkit.settings.keyboard.")
    }
}
