//
//  KeyboardContextTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-22.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import MockingKit
import UIKit
@testable import KeyboardKit

class KeyboardContextTests: QuickSpec {
    
    override func spec() {
        
        var controller: KeyboardInputViewController!
        var context: KeyboardContext!
        var proxy: MockTextDocumentProxy!
        var traits: MockTraitCollection!
        
        beforeEach {
            controller = KeyboardInputViewController()
            proxy = MockTextDocumentProxy()
            traits = MockTraitCollection()
            context = KeyboardContext(controller: controller, keyboardType: .images)
            context.traitCollection = traits
            context.textDocumentProxy = proxy
        }
        
        describe("initialization") {
            
            it("applies provided params") {
                context = KeyboardContext(controller: controller, keyboardType: .images)
                expect(context.device).to(be(UIDevice.current))
                
                expect(context.keyboardType).to(equal(.images))
                expect(context.locale).to(equal(.current))
                expect(context.locales).to(equal([.current]))
                
                expect(context.hasDictationKey).to(equal(controller.hasDictationKey))
                expect(context.hasFullAccess).to(equal(controller.hasFullAccess))
                expect(context.needsInputModeSwitchKey).to(equal(controller.needsInputModeSwitchKey))
                expect(context.primaryLanguage).to(beNil())
                expect(context.textDocumentProxy).to(be(controller.textDocumentProxy))
                expect(context.textInputMode).to(beNil())
                expect(context.traitCollection).to(equal(controller.traitCollection))
            }
        }
        
        describe("color scheme") {
            
            it("is derived from trait collection") {
                traits.userInterfaceStyleValue = .light
                expect(context.colorScheme).to(equal(.light))
                traits.userInterfaceStyleValue = .dark
                expect(context.colorScheme).to(equal(.dark))
            }
        }
        
        describe("keybpard appearance") {
            
            it("is derived from proxy") {
                proxy.keyboardAppearance = .light
                expect(context.keyboardAppearance).to(equal(.light))
                proxy.keyboardAppearance = .dark
                expect(context.keyboardAppearance).to(equal(.dark))
            }
        }
        
        describe("syncing context with controller") {
            
            it("updates some properties") {
                let context = KeyboardContext(controller: controller, keyboardType: .images)
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
