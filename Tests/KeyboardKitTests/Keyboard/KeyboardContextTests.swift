//
//  KeyboardContextTests.swift
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

class KeyboardContextTests: XCTestCase {

    var context: KeyboardContext!
    var proxy: MockTextDocumentProxy!
    var traits: MockTraitCollection!

    override func setUp() {
        proxy = MockTextDocumentProxy()
        traits = MockTraitCollection()
        context = KeyboardContext()
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

    #if os(iOS) || os(tvOS)
    func assert(_ context: KeyboardContext, isSyncedWith controller: KeyboardInputViewController) {
        XCTAssertEqual(context.hasDictationKey, controller.hasDictationKey)
        XCTAssertEqual(context.hasFullAccess, controller.hasFullAccess)
        XCTAssertEqual(context.needsInputModeSwitchKey, controller.needsInputModeSwitchKey)
        XCTAssertEqual(context.primaryLanguage, controller.primaryLanguage)
        XCTAssertEqual(context.screenSize, controller.view.window?.screen.bounds.size ?? .zero)
        XCTAssertEqual(context.textInputMode, controller.textInputMode)
        eventually {
            XCTAssertTrue(context.textDocumentProxy === controller.textDocumentProxy)
            XCTAssertEqual(context.traitCollection, controller.traitCollection)
        }
    }
    #endif


    func testInitializerSetsDefaultValues() {
        XCTAssertEqual(context.deviceType, .current)
        XCTAssertFalse(context.hasDictationKey)
        XCTAssertFalse(context.hasFullAccess)
        XCTAssertNil(context.keyboardDictationReplacement)
        XCTAssertEqual(context.keyboardType, .alphabetic(.lowercased))
        XCTAssertEqual(context.locale, .current)
        XCTAssertEqual(context.locales, [.current])
        XCTAssertFalse(context.needsInputModeSwitchKey)
        XCTAssertTrue(context.prefersAutocomplete)
        XCTAssertNil(context.primaryLanguage)
        XCTAssertEqual(context.screenSize, .zero)
        XCTAssertNotNil(context.textDocumentProxy)
        XCTAssertNil(context.textInputMode)
        XCTAssertNotNil(context.traitCollection)
    }

    #if os(iOS) || os(tvOS)
    func testInitializerCanSyncWithController() {
        let controller = KeyboardInputViewController()
        context = KeyboardContext(controller: controller)
        assert(context, isSyncedWith: controller)
    }
    #endif

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

    #if os(iOS) || os(tvOS)
    func testSyncingContextWithControllerUpdatesSomeProperties() {
        let controller = KeyboardInputViewController()
        let context = KeyboardContext(controller: controller)
        context.sync(with: controller)
        assert(context, isSyncedWith: controller)
    }
    #endif
}
#endif
