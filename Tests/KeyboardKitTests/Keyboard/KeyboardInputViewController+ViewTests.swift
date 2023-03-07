//
//  KeyboardInputViewController+ViewTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import SwiftUI
import UIKit
import XCTest

class KeyboardInputViewController_ViewTests: XCTestCase {

    var vc: KeyboardInputViewController!

    override func setUp() {
        vc = KeyboardInputViewController()
    }

    func testSettingUpViewRemovesAllOtherViewControllers() {
        let subview = UIView()
        XCTAssertFalse(vc.view.subviews.contains(subview))
        vc.view.addSubview(subview)
        XCTAssertTrue(vc.view.subviews.contains(subview))
        vc.setup(with: Text("Hello"))
        XCTAssertFalse(vc.view.subviews.contains(subview))
    }

    func testSettingUpViewAddsChildControllerWithEnvironmentData() {
        XCTAssertEqual(vc.children.count, 0)
        vc.setup(with: Text("Hello"))
        XCTAssertEqual(vc.children.count, 1)
        XCTAssertFalse(vc.children[0] is KeyboardHostingController<Text>)
    }
}
#endif
