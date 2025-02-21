//
//  KeyboardSettings+AddedLocalesTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-02-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

final class KeyboardSettings_AddedLocalesTests: XCTestCase {
    
    var settings: KeyboardSettings!
    
    override func setUp() {
        settings = .init()
    }
    
    override func tearDown() {
        settings.addedLocales = []
    }
    
    func testAddedLocalesArePersisted() {
        settings.addedLocales = .keyboardKitSupported
        let allIds = settings.addedLocales.map { $0.localeIdentifier }
        let other = KeyboardSettings()
        let otherIds = other.addedLocales.map { $0.localeIdentifier }
        XCTAssertEqual(allIds, otherIds)
    }
    
    func testCanGetAddedLocaleForLocale() {
        settings.addedLocales = [
            .init(.swedish),
            .init(.english, layoutType: .qwerty)
        ]
        XCTAssertNotNil(settings.firstAddedLocale(for: .swedish))
        XCTAssertNotNil(settings.firstAddedLocale(for: .english))
        XCTAssertNil(settings.firstAddedLocale(for: .finnish))
    }
    
    func testCanGetAddedLocaleForLocaleAndLayoutType() {
        settings.addedLocales = [
            .init(.swedish),
            .init(.english, layoutType: .qwerty)
        ]
        XCTAssertNil(settings.firstAddedLocale(for: .swedish, layoutType: .qwerty))
        XCTAssertNotNil(settings.firstAddedLocale(for: .english, layoutType: .qwerty))
        XCTAssertNil(settings.firstAddedLocale(for: .finnish, layoutType: .qwerty))
    }
    
    func testCanCheckIfAnySpecificLocaleIsAdded() {
        let locales: [Locale] = [.swedish, .english]
        settings.addedLocales = locales.map { .init($0) }
        XCTAssertTrue(settings.hasAddedLocale(.swedish))
        XCTAssertTrue(settings.hasAddedLocale(.english))
        XCTAssertFalse(settings.hasAddedLocale(.finnish))
    }
    
    func testCanCheckIfAnySpecificLocaleAndLayoutTypeIsAdded() {
        let locales: [Locale] = [.swedish, .english]
        settings.addedLocales = locales.map { .init($0) }
        XCTAssertFalse(settings.hasAddedLocale(.swedish, withLayoutType: .qwerty))
        XCTAssertFalse(settings.hasAddedLocale(.english, withLayoutType: .qwerty))
        XCTAssertFalse(settings.hasAddedLocale(.finnish, withLayoutType: .qwerty))
        settings.addedLocales = locales.map { .init($0, layoutType: .qwerty) }
        XCTAssertTrue(settings.hasAddedLocale(.swedish, withLayoutType: .qwerty))
        XCTAssertTrue(settings.hasAddedLocale(.english, withLayoutType: .qwerty))
        XCTAssertFalse(settings.hasAddedLocale(.finnish, withLayoutType: .qwerty))
    }
}
