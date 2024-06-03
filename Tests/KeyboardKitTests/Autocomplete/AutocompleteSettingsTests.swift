//
//  AutocompleteSettingsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-02.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

final class AutocompleteSettingsTests: XCTestCase {

    func testHasValidDefaultPrefix() {
        let prefix = AutocompleteSettings.prefix
        XCTAssertEqual(prefix, "com.keyboardkit.settings.autocomplete.")
    }
}
