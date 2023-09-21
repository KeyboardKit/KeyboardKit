//
//  RepeatGestureTimerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

class RepeatGestureTimerTests: XCTestCase {

    let timer = Gestures.RepeatTimer.shared

    override func tearDown() {
        timer.stop()
    }


    func testTimeIntervalIsShort() {
        XCTAssertEqual(timer.timeInterval, 0.1)
    }


    func testDurationIsNilIfTimerHasNotBeenStarted() {
        XCTAssertNil(timer.duration)
    }

    func testDurationIsNotNilIfTimerHasBeenStartedButNotStopped() {
        timer.start {}
        XCTAssertNotNil(timer.duration)
    }

    func testDurationIsNotNilIfTimerHasBeenStartedThenStopped() {
        timer.start {}
        timer.stop()
        XCTAssertNil(timer.duration)
    }

    func testDurationIsTheTimeThatHasPassedSinceTheTimerWasLastStarted() {
        timer.start {}
        timer.modifyStartDate(to: Date().addingTimeInterval(-5))
        guard let duration = timer.duration else { return XCTFail("Timer duration is invalid") }
        XCTAssertTrue(duration < 5.1)
    }


    func testIsActiveIsFalseIfTimerHasNotBeenStarted() {
        XCTAssertFalse(timer.isActive)
    }

    func testDurationIsTrueIfTimerHasBeenStartedButNotStopped() {
        timer.start {}
        XCTAssertTrue(timer.isActive)
    }

    func testDurationIsFalseIfTimerHasBeenStartedThenStopped() {
        timer.start {}
        timer.stop()
        XCTAssertFalse(timer.isActive)
    }
}
