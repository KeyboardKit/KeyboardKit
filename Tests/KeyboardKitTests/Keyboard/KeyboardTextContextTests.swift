//
//  KeyboardTextContextTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-22.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import MockingKit
import XCTest
import UIKit

@testable import KeyboardKit

class KeyboardTextContextTests: XCTestCase {

    var context: KeyboardTextContext!
    var proxy: MockTextDocumentProxy!
    var controller: MockKeyboardInputViewController!

    override func setUp() {
        proxy = MockTextDocumentProxy()
        context = KeyboardTextContext()
        controller = MockKeyboardInputViewController()
        controller.textDocumentProxyReplacement = proxy
    }

    func assert(_ context: KeyboardTextContext, isSyncedWith controller: KeyboardInputViewController) {
        eventually {
            XCTAssertEqual(context.documentContextBeforeInput, controller.textDocumentProxy.documentContextBeforeInput)
            XCTAssertEqual(context.documentContextAfterInput, controller.textDocumentProxy.documentContextAfterInput)
            XCTAssertEqual(context.selectedText, controller.textDocumentProxy.selectedText)
        }
    }

    func testInitializerSetsDefaultValues() {
        XCTAssertNil(context.documentContextBeforeInput)
        XCTAssertNil(context.documentContextAfterInput)
        XCTAssertNil(context.selectedText)
    }

    func testSyncingContextWithControllerUpdatesSomeProperties() {
        let controller = MockKeyboardInputViewController()
        proxy.documentContextBeforeInput = "foo"
        proxy.documentContextAfterInput = "bar"
        proxy.selectedText = "baz"
        context.sync(with: controller)
        assert(context, isSyncedWith: controller)
    }
}
#endif
