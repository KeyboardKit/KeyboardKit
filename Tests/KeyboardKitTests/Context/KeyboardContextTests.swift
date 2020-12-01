//
//  KeyboardContextTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-06-22.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class KeyboardContextTests: QuickSpec {
    
    override func spec() {
        
        var actionHandler: KeyboardActionHandler!
        var controller: KeyboardInputViewController!
        
        beforeEach {
            actionHandler = MockKeyboardActionHandler()
            controller = KeyboardInputViewController()
        }
        
        describe("syncing context with controller") {
            
            it("updates some properties") {
                let context = StandardKeyboardContext(
                    controller: controller,
                    actionHandler: actionHandler,
                    keyboardType: .images
                )
                context.sync(with: controller)
                expect(context.deviceOrientation).to(equal(controller.deviceOrientation))
                expect(context.hasDictationKey).to(equal(controller.hasDictationKey))
                expect(context.hasFullAccess).to(equal(controller.hasFullAccess))
                expect(context.needsInputModeSwitchKey).to(equal(controller.needsInputModeSwitchKey))
                expect(context.primaryLanguage).to(beNil())
                expect(context.textDocumentProxy).to(be(controller.textDocumentProxy))
                expect(context.textInputMode).to(beNil())
                expect(context.traitCollection).to(equal(controller.traitCollection))
            }
        }
    }
}
