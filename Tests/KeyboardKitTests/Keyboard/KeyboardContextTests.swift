//
//  KeyboardContextTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-22.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import MockingKit
import UIKit
import XCTest

@testable import KeyboardKit

class KeyboardContextTests: XCTestCase {

    var controller: KeyboardInputViewController!
    var context: KeyboardContext!
    var proxy: MockTextDocumentProxy!
    var traits: MockTraitCollection!

    override func setUp() {
        controller = KeyboardInputViewController()
        proxy = MockTextDocumentProxy()
        traits = MockTraitCollection()
        context = KeyboardContext(controller: controller, keyboardType: .images)
        context.traitCollection = traits
        context.textDocumentProxy = proxy
    }

    
    func locale(for id: String) -> Locale {
        Locale(identifier: id)
    }

    func hasKeyboardLocaleResult(for locale: KeyboardLocale) -> Bool {
        context.hasKeyboardLocale(locale)
    }

    func hasKeyboardTypeResult(for type: KeyboardType) -> Bool {
        context.hasKeyboardType(type)
    }


    func testInitializationAppliesProvidedParams() {
        context = KeyboardContext(controller: controller, keyboardType: .images)

        XCTAssertEqual(context.keyboardType, .images)
        XCTAssertEqual(context.locale, .current)
        XCTAssertEqual(context.locales, [.current])

        XCTAssertEqual(context.deviceType, .current)
        XCTAssertEqual(context.hasDictationKey, controller.hasDictationKey)
        XCTAssertEqual(context.hasFullAccess, controller.hasFullAccess)
        XCTAssertEqual(context.needsInputModeSwitchKey, controller.needsInputModeSwitchKey)
        XCTAssertNil(context.primaryLanguage)
        XCTAssertNil(context.textInputMode)
        eventually {
            XCTAssertTrue(self.context.textDocumentProxy === self.controller.textDocumentProxy)
            XCTAssertEqual(self.context.traitCollection, self.controller.traitCollection)
        }
    }


    func testColorSchemeIsDerivedFromTraitCollection() {
        traits.userInterfaceStyleValue = .light
        XCTAssertEqual(context.colorScheme, .light)
        traits.userInterfaceStyleValue = .dark
        XCTAssertEqual(context.colorScheme, .dark)
    }


    func testKeyboardAppearanceIsDerivedFromProxy() {
        proxy.keyboardAppearance = .light
        XCTAssertEqual(context.keyboardAppearance, .light)
        proxy.keyboardAppearance = .dark
        XCTAssertEqual(context.keyboardAppearance, .dark)
    }


    func testHasKeyboardLocaleReturnsTrueForMatchingType() {
        context.setLocale(.swedish)
        XCTAssertTrue(hasKeyboardLocaleResult(for: .swedish))
        XCTAssertFalse(hasKeyboardLocaleResult(for: .finnish))
        XCTAssertFalse(hasKeyboardLocaleResult(for: .german))
        XCTAssertFalse(hasKeyboardLocaleResult(for: .norwegian))
    }

    func testHasKeyboardTypeReturnsTrueForMatchingType() {
        context.keyboardType = .emojis
        XCTAssertTrue(hasKeyboardTypeResult(for: .emojis))
        XCTAssertFalse(hasKeyboardTypeResult(for: .alphabetic(.auto)))
        XCTAssertFalse(hasKeyboardTypeResult(for: .custom(named: "")))
        XCTAssertFalse(hasKeyboardTypeResult(for: .email))
        XCTAssertFalse(hasKeyboardTypeResult(for: .images))
        XCTAssertFalse(hasKeyboardTypeResult(for: .numeric))
        XCTAssertFalse(hasKeyboardTypeResult(for: .symbolic))
    }


    func testSelectingNextLocaleSelectsFirstItemIfTheCurrentLocaleIsNotInLocales() {
        context.locale = locale(for: "sv")
        context.locales = [locale(for: "en"), locale(for: "fi"), locale(for: "da")]
        context.selectNextLocale()
        XCTAssertEqual(context.locale.identifier, "en")
    }

    func testSelectingNextLocaleSelectsFirstItemIfTheCurrentLocaleIsLastInLocales() {
        context.locale = locale(for: "sv")
        context.locales = [locale(for: "en"), locale(for: "fi"), locale(for: "da")]
        context.locale = locale(for: "da")
        context.selectNextLocale()
        XCTAssertEqual(context.locale.identifier, "en")
    }

    func testSelectingNextLocaleSelectsNextItemIfTheCurrentLocaleIsNotLastInLocales() {
        context.locale = locale(for: "sv")
        context.locales = [locale(for: "en"), locale(for: "fi"), locale(for: "da")]
        context.locale = locale(for: "fi")
        context.selectNextLocale()
        XCTAssertEqual(context.locale.identifier, "da")
    }


    func testSettingKeyboardLocaleSetsContextLocale() {
        context.locale = locale(for: "sv")
        context.setLocale(.catalan)
        XCTAssertEqual(context.locale.identifier, "ca")
    }


    func testSyncingContextWithControllerUpdatesSomeProperties() {
        let context = KeyboardContext(controller: controller, keyboardType: .images)
        context.sync(with: controller)
        XCTAssertEqual(context.hasDictationKey, controller.hasDictationKey)
        XCTAssertEqual(context.hasFullAccess, controller.hasFullAccess)
        XCTAssertEqual(context.needsInputModeSwitchKey, controller.needsInputModeSwitchKey)
        XCTAssertNil(context.primaryLanguage)
        #if os(iOS) || os(macOS)
        XCTAssertEqual(context.screenOrientation, controller.screenOrientation)
        #endif
        XCTAssertNil(context.textInputMode)
        eventually {
            XCTAssertTrue(context.textDocumentProxy === self.controller.textDocumentProxy)
            XCTAssertEqual(context.traitCollection, self.controller.traitCollection)
        }
    }
}
#endif
