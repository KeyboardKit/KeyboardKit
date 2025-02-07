//
//  KeyboardContext+LocalesTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-02-07.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

class KeyboardContext_LocalesTests: XCTestCase {

    var context: KeyboardContext!
    
    let locales: [Locale] = [.swedish, .english]
    let addedLocales: [Keyboard.AddedLocale] = [
        .init(.swedish),
        .init(.swedish, layoutType: .qwerty),
        .init(.finnish)
    ]
    
    func cleanup() {
        context.locale = .english
        context.keyboardLayoutType = nil
        context.settings.addedLocales = []
        context.settings.spaceTrailingAction = nil
    }
    
    override func setUp() {
        context = KeyboardContext()
        cleanup()
    }

    override func tearDown() {
        cleanup()
    }
    
    func testCanResolveEnabledLocales() {
        context.locales = locales
        XCTAssertEqual(context.enabledLocales, locales)
        context.settings.addedLocales = addedLocales
        XCTAssertEqual(context.enabledLocales, addedLocales.compactMap { $0.locale })
    }
    
    func testCanResolveEnabledLocaleDataSource() {
        context.locales = locales
        XCTAssertEqual(context.enabledLocalesDataSource, .context)
        context.settings.addedLocales = addedLocales
        XCTAssertEqual(context.enabledLocalesDataSource, .added)
    }
    
    func testCanResolveMultipleEnabledState() {
        XCTAssertFalse(context.hasMultipleEnabledLocales)
        context.locales = locales
        XCTAssertTrue(context.hasMultipleEnabledLocales)
        context.locales = []
        context.settings.addedLocales = addedLocales
        XCTAssertTrue(context.hasMultipleEnabledLocales)
    }
    
    func testCanResolveSpacebarContextMenuState() {
        XCTAssertFalse(context.shouldAddLocaleContextMenuToSpaceBar)
        context.locales = locales
        XCTAssertFalse(context.shouldAddLocaleContextMenuToSpaceBar)
        context.settings.spaceTrailingAction = .localeContextMenu
        XCTAssertTrue(context.shouldAddLocaleContextMenuToSpaceBar)
        context.locales = []
        context.settings.addedLocales = addedLocales
        XCTAssertTrue(context.shouldAddLocaleContextMenuToSpaceBar)
    }
    
    func assertSelection(locale: Locale, layoutType: Keyboard.LayoutType?) {
        XCTAssertEqual(context.locale.identifier, locale.identifier)
        XCTAssertEqual(context.keyboardLayoutType, layoutType)
    }
    
    func testCanSelectLocaleAtIndex() {
        assertSelection(locale: .english, layoutType: nil)
        context.locales = locales
        context.selectLocale(at: 0)
        assertSelection(locale: .swedish, layoutType: nil)
        context.selectLocale(at: 1)
        assertSelection(locale: .english, layoutType: nil)
        
        context.locales = []
        context.settings.addedLocales = addedLocales
        context.selectLocale(at: 0)
        assertSelection(locale: .swedish, layoutType: nil)
        context.selectLocale(at: 1)
        assertSelection(locale: .swedish, layoutType: .qwerty)
        context.selectLocale(at: 2)
        assertSelection(locale: .finnish, layoutType: nil)
        
        context.selectLocale(at: -1)
        assertSelection(locale: .finnish, layoutType: nil)
        context.selectLocale(at: 30)
        assertSelection(locale: .finnish, layoutType: nil)
    }
    
    func testCanSelectNextLocale() {
        assertSelection(locale: .english, layoutType: nil)
        context.locales = locales
        context.selectNextLocale()
        assertSelection(locale: .swedish, layoutType: nil)
        context.selectNextLocale()
        assertSelection(locale: .english, layoutType: nil)
        context.selectNextLocale()
        assertSelection(locale: .swedish, layoutType: nil)
        
        context.locales = []
        context.settings.addedLocales = addedLocales
        context.selectNextLocale()
//        assertSelection(locale: .swedish, layoutType: nil)
//        context.selectNextLocale()
        assertSelection(locale: .swedish, layoutType: .qwerty)
        context.selectNextLocale()
        assertSelection(locale: .finnish, layoutType: nil)
        context.selectNextLocale()
        assertSelection(locale: .swedish, layoutType: nil)
    }
}
