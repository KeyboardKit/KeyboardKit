//
//  StandardKeyboardContextTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class ObservableKeyboardContextTests: QuickSpec {
    
    override func spec() {
        
        var controller: KeyboardInputViewController!
        
        beforeEach {
            controller = KeyboardInputViewController()
        }
        
        describe("context") {
            
            it("can be created with params") {
                let context = ObservableKeyboardContext(controller: controller, keyboardType: .images)
                                
                expect(context.device).to(be(UIDevice.current))
                
                expect(context.keyboardType).to(equal(.images))
                expect(context.locale).to(equal(.current))
                
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
