//
//  KeyboardLayout+StandardLayoutServiceTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-17.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLayout_StandardLayoutServiceTests: XCTestCase {

    var context: KeyboardContext!
    var service: KeyboardLayout.StandardLayoutService!

    override func setUp() {
        context = .init()
        service = .init(
            baseService: KeyboardLayout.DeviceBasedLayoutService(),
            localizedServices: [TestService()]
        )
    }
    
    override func tearDown() {
        KeyboardLayout.StandardLayoutService.localizedServiceResolver = nil
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
        XCTAssertTrue(result is KeyboardLayout.DeviceBasedLayoutService)
        XCTAssertEqual(firstItem?.action, .character("q"))
    }
    
    func testCanRegisterLocalizedService() {
        let locale = Locale.albanian
        let new = TestService(localeKey: locale.identifier)
        XCTAssertNil(service.localizedServices.value(for: locale))
        service.registerLocalizedService(new)
        XCTAssertIdentical(service.localizedServices.value(for: locale), new)
    }
    
    func testCanResolveLayoutServiceWithStaticResolver() {
        KeyboardLayout.StandardLayoutService.localizedServiceResolver = { locale in
            if locale == .albanian { return TestService(localeKey: "apa") }
            return nil
        }
        context.locale = .albanian
        XCTAssertNil(service.localizedServices.value(for: .albanian))
        let result = service.keyboardLayoutService(for: context)
        XCTAssertEqual((result as? TestService)?.localeKey, "apa")
        XCTAssertTrue(service.localizedServices.value(for: .albanian) is TestService)
    }
}

private class TestService: KeyboardLayout.BaseLayoutService, LocalizedService {

    init(localeKey: String = "sv") {
        self.localeKey = localeKey
        super.init(
            alphabeticInputSet: .init(rows: [.init(chars: "abcdefghij")]),
            numericInputSet: .numeric,
            symbolicInputSet: .symbolic
        )
    }
    
    var localeKey: String
}
