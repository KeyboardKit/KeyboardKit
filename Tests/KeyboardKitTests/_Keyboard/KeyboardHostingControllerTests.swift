//
//  KeyboardHostingControllerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI
import XCTest
@testable import KeyboardKit

class KeyboardHostingControllerTests: XCTestCase {

    var host: KeyboardHostingController<Text>!
    var input: KeyboardInputViewController!

    override func setUp() {
        host = KeyboardHostingController(rootView: Text(""))
        input = KeyboardInputViewController()
        XCTAssertEqual(input.children.count, 0)
        host.add(to: input)
    }

    func addingToKeyboardControllerAddsHostAsChildController() {
        XCTAssertEqual(input.children.count, 1)
    }

    func addingToKeyboardControllerAddsHostViewAsSubview() {
        XCTAssertTrue(input.view.subviews.last === host.view)
    }

    func addingToKeyboardControllerConfiguresHostView() {
        let view = host.view!
        XCTAssertEqual(view.backgroundColor, .clear)
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
        XCTAssertNotNil(view.leadingAnchor)
        XCTAssertNotNil(view.trailingAnchor)
        XCTAssertNotNil(view.topAnchor)
        XCTAssertNotNil(view.bottomAnchor)
    }
}
#endif
