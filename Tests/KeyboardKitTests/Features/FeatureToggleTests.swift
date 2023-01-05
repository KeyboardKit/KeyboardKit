//
//  FeatureToggleTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class FeatureToggleTests: XCTestCase {

    var toggle: FeatureToggle!

    override func setUp() {
        toggle = .shared
    }

    func result(for feature: FeatureToggle.Feature) -> Bool {
        toggle.isFeatureEnabled(feature)
    }

    func testCanToggleNewButtonGestureEngine() {
        toggle.toggleFeature(.placeholder, .off)
        XCTAssertFalse(result(for: .placeholder))
        toggle.toggleFeature(.placeholder, .on)
        XCTAssertTrue(result(for: .placeholder))
        toggle.reset()
        XCTAssertFalse(result(for: .placeholder))
    }
}
