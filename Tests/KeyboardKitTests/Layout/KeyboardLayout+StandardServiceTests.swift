//
//  KeyboardLayout+StandardServiceTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLayout_StandardServiceTests: XCTestCase {

    var context: KeyboardContext!
    var service: KeyboardLayout.StandardService!

    override func setUp() {
        context = .init()
        service = .init(
            baseService: KeyboardLayout.DeviceBasedService(),
            localizedServices: [TestService()]
        )
    }
    
    override func tearDown() {
        KeyboardLayout.StandardService.localizedServiceResolver = nil
    }

    func testUsesLocalizedServiceIfOneMatchesContext() {
        context.locale = .init(identifier: "sv")
        let layout = service.keyboardLayout(for: context)
        let firstItem = layout.itemRows[0].first
        let result = service.keyboardLayoutService(for: context)
        XCTAssertNotNil(result)
        XCTAssertTrue(result is TestService)
        XCTAssertEqual(firstItem?.action, .character("a"))
    }
    
    func testUsesBaseServiceIfNoLocalizedMatchesContext() {
        context.locale = .init(identifier: "da-DK")
        let layout = service.keyboardLayout(for: context)
        let firstItem = layout.itemRows[0].first
        let result = service.keyboardLayoutService(for: context)
        XCTAssertTrue(result is KeyboardLayout.DeviceBasedService)
        XCTAssertEqual(firstItem?.action, .character("q"))
    }
    
    func testCanRegisterLocalizedService() {
        let locale = KeyboardLocale.albanian
        let new = TestService(localeKey: locale.localeIdentifier)
        XCTAssertNil(service.localizedServices.value(for: locale.locale))
        service.registerLocalizedService(new)
        XCTAssertIdentical(service.localizedServices.value(for: locale.locale), new)
    }
    
    
    func testCanResolveLayoutServiceWithStaticResolver() {
        KeyboardLayout.StandardService.localizedServiceResolver = { locale in
            if locale == .albanian { return TestService(localeKey: "apa") }
            return nil
        }
        context.setLocale(KeyboardLocale.albanian)
        XCTAssertNil(service.localizedServices.value(for: KeyboardLocale.albanian))
        let result = service.keyboardLayoutService(for: context)
        XCTAssertEqual((result as? TestService)?.localeKey, "apa")
        XCTAssertTrue(service.localizedServices.value(for: KeyboardLocale.albanian) is TestService)
    }
}

private class TestService: KeyboardLayout.BaseService, LocalizedService {

    init(localeKey: String = "sv") {
        self.localeKey = localeKey
        super.init(
            alphabeticInputSet: .init(rows: [.init(chars: "abcdefghij")]),
            numericInputSet: .numeric(currency: "$"),
            symbolicInputSet: .symbolic(currencies: "€£¥".chars)
        )
    }
    
    var localeKey: String
}
