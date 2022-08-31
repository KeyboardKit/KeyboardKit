//
//  KeyboardContextTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-22.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
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
        
        func locale(for id: String) -> Locale {
            Locale(identifier: id)
        }
        
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
                
                expect(context.keyboardType).toEventually(equal(.images))
                expect(context.locale).toEventually(equal(.current))
                expect(context.locales).toEventually(equal([.current]))
                
                expect(context.hasDictationKey).toEventually(equal(controller.hasDictationKey))
                expect(context.hasFullAccess).toEventually(equal(controller.hasFullAccess))
                expect(context.needsInputModeSwitchKey).toEventually(equal(controller.needsInputModeSwitchKey))
                expect(context.primaryLanguage).toEventually(beNil())
                expect(context.textDocumentProxy).toEventually(be(controller.textDocumentProxy))
                expect(context.textInputMode).toEventually(beNil())
                expect(context.traitCollection).toEventually(equal(controller.traitCollection))
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

        describe("keyboard appearance") {

            it("is derived from proxy") {
                proxy.keyboardAppearance = .light
                expect(context.keyboardAppearance).to(equal(.light))
                proxy.keyboardAppearance = .dark
                expect(context.keyboardAppearance).to(equal(.dark))
            }
        }

        describe("has keyboard locale") {

            func result(for locale: KeyboardLocale) -> Bool {
                context.hasKeyboardLocale(locale)
            }

            it("returns true for matching type") {
                context.setLocale(.swedish)
                expect(result(for: .swedish)).to(beTrue())
                expect(result(for: .finnish)).to(beFalse())
                expect(result(for: .german)).to(beFalse())
                expect(result(for: .norwegian)).to(beFalse())
            }
        }

        describe("has keyboard type") {

            func result(for type: KeyboardType) -> Bool {
                context.hasKeyboardType(type)
            }

            it("returns true for matching type") {
                context.keyboardType = .emojis
                expect(result(for: .emojis)).to(beTrue())
                expect(result(for: .alphabetic(.auto))).to(beFalse())
                expect(result(for: .custom(named: ""))).to(beFalse())
                expect(result(for: .email)).to(beFalse())
                expect(result(for: .images)).to(beFalse())
                expect(result(for: .numeric)).to(beFalse())
                expect(result(for: .symbolic)).to(beFalse())
            }
        }

        describe("selecting next locale") {

            beforeEach {
                context.locale = locale(for: "sv")
                context.locales = [locale(for: "en"), locale(for: "fi"), locale(for: "da")]
            }

            it("select first item if the current locale is not in locales") {
                context.selectNextLocale()
                expect(context.locale.identifier).to(equal("en"))
            }

            it("select first item if the current locale is last in locales") {
                context.locale = locale(for: "da")
                context.selectNextLocale()
                expect(context.locale.identifier).to(equal("en"))
            }

            it("select next item if the current locale is not last in locales") {
                context.locale = locale(for: "fi")
                context.selectNextLocale()
                expect(context.locale.identifier).to(equal("da"))
            }
        }

        describe("setting keyboard locale") {

            beforeEach {
                context.locale = locale(for: "sv")
            }

            it("sets the context locale") {
                context.setLocale(.catalan)
                expect(context.locale.identifier).to(equal("ca"))
            }
        }
        
        describe("syncing context with controller") {
            
            it("updates some properties") {
                let context = KeyboardContext(controller: controller, keyboardType: .images)
                context.sync(with: controller)
                expect(context.hasDictationKey).toEventually(equal(controller.hasDictationKey))
                expect(context.hasFullAccess).toEventually(equal(controller.hasFullAccess))
                expect(context.needsInputModeSwitchKey).toEventually(equal(controller.needsInputModeSwitchKey))
                expect(context.primaryLanguage).toEventually(beNil())
                #if os(iOS) || os(macOS)
                expect(context.screenOrientation).toEventually(equal(controller.screenOrientation))
                #endif
                expect(context.textDocumentProxy).toEventually(be(controller.textDocumentProxy))
                expect(context.textInputMode).toEventually(beNil())
                expect(context.traitCollection).toEventually(equal(controller.traitCollection))
            }
        }
    }
}
#endif
