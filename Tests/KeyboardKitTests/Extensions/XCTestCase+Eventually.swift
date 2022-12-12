//
//  XCTestCase+Eventually.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-29.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import XCTest

extension XCTestCase {

    func eventually(timeout: TimeInterval = 0.01, closure: @escaping () -> Void) {
        let expectation = self.expectation(description: "")
        expectation.fulfillAfter(timeout)
        self.waitForExpectations(timeout: 60) { _ in
            closure()
        }
    }
}

extension XCTestExpectation {

    func fulfillAfter(_ time: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.fulfill()
        }
    }
}
