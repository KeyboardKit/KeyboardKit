//
//  Keyboard+LayoutTypeTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-02-08.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI
import XCTest

class Keyboard_LayoutTypeTests: XCTestCase {
    
    func create(withId id: String) -> Keyboard.LayoutType? {
        .init(id: id)
    }
    
    func testCanCreateFromId() {
        XCTAssertEqual(create(withId: "azerty"), .azerty)
        XCTAssertEqual(create(withId: "colemak"), .colemak)
        XCTAssertEqual(create(withId: "qwerty"), .qwerty)
        XCTAssertEqual(create(withId: "qwerty_catalan"), .qwerty_catalan)
        XCTAssertEqual(create(withId: "qwertz"), .qwertz)
        XCTAssertEqual(create(withId: "vietnamese_telex_azerty"), .vietnamese_telex(.azerty))
        XCTAssertEqual(create(withId: "vietnamese_telex_colemak"), .vietnamese_telex(.colemak))
        XCTAssertEqual(create(withId: "vietnamese_telex_qwerty"), .vietnamese_telex(.qwerty))
        XCTAssertEqual(create(withId: "vietnamese_telex_qwertz"), .vietnamese_telex(.qwertz))
        XCTAssertEqual(create(withId: "vietnamese_viqr_azerty"), .vietnamese_viqr(.azerty))
        XCTAssertEqual(create(withId: "vietnamese_viqr_colemak"), .vietnamese_viqr(.colemak))
        XCTAssertEqual(create(withId: "vietnamese_viqr_qwerty"), .vietnamese_viqr(.qwerty))
        XCTAssertEqual(create(withId: "vietnamese_viqr_qwertz"), .vietnamese_viqr(.qwertz))
        XCTAssertEqual(create(withId: "vietnamese_vni_azerty"), .vietnamese_vni(.azerty))
        XCTAssertEqual(create(withId: "vietnamese_vni_colemak"), .vietnamese_vni(.colemak))
        XCTAssertEqual(create(withId: "vietnamese_vni_qwerty"), .vietnamese_vni(.qwerty))
        XCTAssertEqual(create(withId: "vietnamese_vni_qwertz"), .vietnamese_vni(.qwertz))
    }

    func displayName(for type: Keyboard.LayoutType) -> String {
        type.displayName
    }

    func testDisplayNameIsValidForAllTypes() {
        XCTAssertEqual(displayName(for: .azerty), "AZERTY")
        XCTAssertEqual(displayName(for: .colemak), "Colemak")
        XCTAssertEqual(displayName(for: .qwerty), "QWERTY")
        XCTAssertEqual(displayName(for: .qwerty_catalan), "QWERTY - Catalan")
        XCTAssertEqual(displayName(for: .qwertz), "QWERTZ")
        XCTAssertEqual(displayName(for: .vietnamese_telex(.azerty)), "Telex - AZERTY")
        XCTAssertEqual(displayName(for: .vietnamese_telex(.colemak)), "Telex - Colemak")
        XCTAssertEqual(displayName(for: .vietnamese_telex(.qwerty)), "Telex - QWERTY")
        XCTAssertEqual(displayName(for: .vietnamese_telex(.qwertz)), "Telex - QWERTZ")
        XCTAssertEqual(displayName(for: .vietnamese_viqr(.azerty)), "VIQR - AZERTY")
        XCTAssertEqual(displayName(for: .vietnamese_viqr(.colemak)), "VIQR - Colemak")
        XCTAssertEqual(displayName(for: .vietnamese_viqr(.qwerty)), "VIQR - QWERTY")
        XCTAssertEqual(displayName(for: .vietnamese_viqr(.qwertz)), "VIQR - QWERTZ")
        XCTAssertEqual(displayName(for: .vietnamese_vni(.azerty)), "VNI - AZERTY")
        XCTAssertEqual(displayName(for: .vietnamese_vni(.colemak)), "VNI - Colemak")
        XCTAssertEqual(displayName(for: .vietnamese_vni(.qwerty)), "VNI - QWERTY")
        XCTAssertEqual(displayName(for: .vietnamese_vni(.qwertz)), "VNI - QWERTZ")
    }
    
    func id(for type: Keyboard.LayoutType) -> String {
        type.id
    }
    
    func testIdIsValidForAllTypes() {
        XCTAssertEqual(id(for: .azerty), "azerty")
        XCTAssertEqual(id(for: .colemak), "colemak")
        XCTAssertEqual(id(for: .qwerty), "qwerty")
        XCTAssertEqual(id(for: .qwerty_catalan), "qwerty_catalan")
        XCTAssertEqual(id(for: .qwertz), "qwertz")
        XCTAssertEqual(id(for: .vietnamese_telex(.azerty)), "vietnamese_telex_azerty")
        XCTAssertEqual(id(for: .vietnamese_telex(.colemak)), "vietnamese_telex_colemak")
        XCTAssertEqual(id(for: .vietnamese_telex(.qwerty)), "vietnamese_telex_qwerty")
        XCTAssertEqual(id(for: .vietnamese_telex(.qwertz)), "vietnamese_telex_qwertz")
        XCTAssertEqual(id(for: .vietnamese_viqr(.azerty)), "vietnamese_viqr_azerty")
        XCTAssertEqual(id(for: .vietnamese_viqr(.colemak)), "vietnamese_viqr_colemak")
        XCTAssertEqual(id(for: .vietnamese_viqr(.qwerty)), "vietnamese_viqr_qwerty")
        XCTAssertEqual(id(for: .vietnamese_viqr(.qwertz)), "vietnamese_viqr_qwertz")
        XCTAssertEqual(id(for: .vietnamese_vni(.azerty)), "vietnamese_vni_azerty")
        XCTAssertEqual(id(for: .vietnamese_vni(.colemak)), "vietnamese_vni_colemak")
        XCTAssertEqual(id(for: .vietnamese_vni(.qwerty)), "vietnamese_vni_qwerty")
        XCTAssertEqual(id(for: .vietnamese_vni(.qwertz)), "vietnamese_vni_qwertz")
    }
}
