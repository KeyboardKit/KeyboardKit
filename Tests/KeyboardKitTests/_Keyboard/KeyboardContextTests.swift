//
//  KeyboardContextTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-22.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

class KeyboardContextTests: XCTestCase {

    var context: KeyboardContext!

    #if os(iOS) || os(tvOS)
    var proxy: MockTextDocumentProxy!
    var traits: MockTraitCollection!
    #endif

    override func setUp() {
        context = KeyboardContext()
        #if os(iOS) || os(tvOS)
        proxy = MockTextDocumentProxy()
        traits = MockTraitCollection()
        context.traitCollection = traits
        context.originalTextDocumentProxy = proxy
        #endif
    }

    override func tearDown() {
        context.locale = .init(identifier: "en")
        context.settings.isAutocapitalizationEnabled = true
    }

    
    func locale(for id: String) -> Locale {
        Locale(identifier: id)
    }

    #if os(iOS) || os(tvOS)
    func assert(_ context: KeyboardContext, isSyncedWith controller: KeyboardInputViewController) {
        XCTAssertEqual(context.hasDictationKey, controller.hasDictationKey)
        XCTAssertEqual(context.hasFullAccess, controller.hasFullAccess)
        XCTAssertEqual(context.primaryLanguage, controller.primaryLanguage)
        XCTAssertEqual(context.screenSize, controller.view.window?.screen.bounds.size ?? .zero)
        XCTAssertEqual(context.textInputMode, controller.textInputMode)
        eventually {
            XCTAssertEqual(context.needsInputModeSwitchKey, controller.needsInputModeSwitchKey)
            // XCTAssertTrue(context.textDocumentProxy === controller.textDocumentProxy)
            XCTAssertEqual(context.traitCollection, controller.traitCollection)
        }
    }
    #endif


    func testInitializerSetsDefaultValues() {
        XCTAssertEqual(context.deviceType, .current)
        XCTAssertEqual(context.deviceTypeForKeyboard, .current)
        XCTAssertFalse(context.hasDictationKey)
        XCTAssertFalse(context.hasFullAccess)
        XCTAssertNil(context.keyboardDictationReplacement)
        XCTAssertEqual(context.keyboardType, .alphabetic)
        XCTAssertEqual(context.locale, Locale(identifier: context.settings.localeIdentifier))
        XCTAssertEqual(context.locales, [.current])
        XCTAssertFalse(context.needsInputModeSwitchKey)
        XCTAssertNil(context.primaryLanguage)
        XCTAssertEqual(context.screenSize, .zero)
        #if os(iOS) || os(tvOS)
        XCTAssertNotNil(context.textDocumentProxy)
        XCTAssertNil(context.textInputMode)
        XCTAssertNotNil(context.traitCollection)
        #endif
    }

    #if os(iOS) || os(tvOS)
    func testInitializerCanSyncWithController() {
        let controller = KeyboardInputViewController()
        context = KeyboardContext()
        context.sync(with: controller)
        assert(context, isSyncedWith: controller)
    }

    func testColorSchemeIsDerivedFromTraitCollection() {
        // traits.userInterfaceStyleValue = .light
        // XCTAssertEqual(context.colorScheme, .light)
        // traits.userInterfaceStyleValue = .dark
        // XCTAssertEqual(context.colorScheme, .dark)
    }

    func testKeyboardAppearanceIsDerivedFromProxy() {
        proxy.keyboardAppearance = .light
        XCTAssertEqual(context.keyboardAppearance, .light)
        proxy.keyboardAppearance = .dark
        XCTAssertEqual(context.keyboardAppearance, .dark)
    }
    #endif

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


    func testSettingLocaleSetsContextLocale() {
        context.locale = locale(for: "sv")
        context.locale = .catalan
        XCTAssertEqual(context.locale.identifier, "ca")
    }

    #if os(iOS) || os(tvOS)
    func testSyncingContextWithControllerUpdatesSomeProperties() {
        let controller = KeyboardInputViewController()
        let context = KeyboardContext()
        context.sync(with: controller)
        assert(context, isSyncedWith: controller)
    }
    #endif
}
