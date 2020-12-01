//
//  StandardKeyboardContextTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class StandardKeyboardContextTests: QuickSpec {
    
    override func spec() {
        
        var actionHandler: KeyboardActionHandler!
        var controller: KeyboardInputViewController!
        
        beforeEach {
            actionHandler = MockKeyboardActionHandler()
            controller = KeyboardInputViewController()

        }
        
        describe("context") {
            
            it("can be created with params") {
                let context = StandardKeyboardContext(
                    controller: controller,
                    actionHandler: actionHandler,
                    keyboardType: .images
                )
                
                expect(context.controller).to(be(controller))
                
                expect(context.device).to(be(UIDevice.current))
                
                expect(context.actionHandler).to(be(actionHandler))
                expect(context.emojiCategory).to(equal(.frequent))
                expect(context.inputSetProvider is StandardKeyboardInputSetProvider).to(beTrue())
                expect(context.keyboardType).to(equal(.images))
                
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
