//
//  KeyboardCallout+StandardCalloutServiceTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardCallout_StandardCalloutServiceTests: XCTestCase {

    var service: KeyboardCallout.StandardCalloutService!
    var context: KeyboardContext!
    
    override func setUp() {
        context = KeyboardContext()
        service = .init(keyboardContext: context)
    }
    
    override func tearDown() {
        KeyboardCallout.StandardCalloutService.localizedServiceResolver = nil
    }
    
    func testLocalizedServicesHaveNoDefaultServices() {
        let services = service.localizedServices.dictionary
        XCTAssertEqual(services.keys.count, 0)
    }
    
    func testLocalizedServicesAcceptCustomServices() {
        service = .init(
            keyboardContext: context,
            localizedServices: [
                TestService(localeKey: "en"),
                TestService(localeKey: "sv")
            ]
        )
        let services = service.localizedServices.dictionary
        XCTAssertEqual(services.keys.count, 2)
        XCTAssertTrue(services["en"] is TestService)
        XCTAssertTrue(services["sv"] is TestService)
    }
    
    
    func testCalloutActionsMapsContextLocaleToService() {
        context.locale = Locale.english
        service = .init(
            keyboardContext: context,
            localizedServices: [TestService(localeKey: "en")]
        )
        let action = KeyboardAction.character("a")
        let actions = service.calloutActions(for: action)
        let expected = "en".map { KeyboardAction.character(String($0)) }
        XCTAssertEqual(actions, expected)
    }
    
    func testCalloutActionsReturnsEmptyResultForMissingLocale() {
        context.locale = Locale.swedish
        service = .init(
            keyboardContext: context,
            localizedServices: [TestService(localeKey: "en")]
        )
        let nonEmptyActions = service.calloutActions(for: .character("a"))
        let emptyActions = service.calloutActions(for: .character("k"))
        XCTAssertNotEqual(nonEmptyActions, [])
        XCTAssertEqual(emptyActions, [])
    }
    
    func testCanRegisterLocalizedService() {
        let locale = Locale.albanian
        let new = TestService(localeKey: locale.identifier)
        XCTAssertNil(service.localizedServices.value(for: locale))
        service.registerLocalizedService(new)
        XCTAssertIdentical(service.localizedServices.value(for: locale), new)
    }
    
    
    func testCanResolveLayoutServiceWithStaticResolver() {
        KeyboardCallout.StandardCalloutService.localizedServiceResolver = { locale in
            if locale == .albanian { return TestService(localeKey: "apa") }
            return nil
        }
        context.locale = .albanian
        XCTAssertNil(service.localizedServices.value(for: Locale.albanian))
        let result = service.service(for: context)
        XCTAssertEqual((result as? TestService)?.localeKey, "apa")
        XCTAssertTrue(service.localizedServices.value(for: Locale.albanian) is TestService)
    }
}

private class TestService: KeyboardCalloutService, LocalizedService {

    init(localeKey: String) {
        self.localeKey = localeKey
    }
    
    let localeKey: String
    
    func calloutActions(
        for action: KeyboardAction
    ) -> [KeyboardAction] {
        switch action {
        case .character(let char):
            guard char == "a" else { return [] }
            return localeKey.chars.map { .character($0) }
        default: return []
        }
    }

    func triggerFeedbackForSelectionChange() {}
}
