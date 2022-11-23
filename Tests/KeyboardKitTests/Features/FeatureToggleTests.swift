//
//  FeatureToggleTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
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
        XCTAssertFalse(result(for: .newButtonGestureEngine))
        toggle.toggleFeature(.newButtonGestureEngine, isOn: true)
        XCTAssertTrue(result(for: .newButtonGestureEngine))
        toggle.toggleFeature(.newButtonGestureEngine, isOn: false)
        XCTAssertFalse(result(for: .newButtonGestureEngine))
    }
}
#endif
