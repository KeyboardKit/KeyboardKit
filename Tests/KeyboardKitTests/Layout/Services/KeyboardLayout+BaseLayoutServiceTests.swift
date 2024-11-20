//
//  KeyboardLayout+BaseServiceTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLayout_BaseLayoutServiceTests: XCTestCase {

    var service: KeyboardLayout.BaseLayoutService!
    var context: KeyboardContext!
    var layoutConfig: KeyboardLayout.Configuration!

    let alpha = [["a", "b", "c"]]
    var alphaSet: InputSet!
    let numeric = [["a", "b", "c"]]
    var numericSet: InputSet!
    let symbolic = [[",", ".", "-"]]
    var symbolicSet: InputSet!

    override func setUp() {
        alphaSet = InputSet(rows: alpha.map(InputSet.ItemRow.init(chars:)))
        numericSet = InputSet(rows: numeric.map(InputSet.ItemRow.init(chars:)))
        symbolicSet = InputSet(rows: symbolic.map(InputSet.ItemRow.init(chars:)))

        context = .init()
        layoutConfig = .standard(for: context)
        service = .init(
            alphabeticInputSet: alphaSet,
            numericInputSet: numericSet,
            symbolicInputSet: symbolicSet
        )
    }


    func testLayoutContainsExpectedItemRows() {
        let rows = service.itemRows(for: context)
        let expected = KeyboardLayout(itemRows: rows)
        let layout = service.keyboardLayout(for: context)
        XCTAssertEqual(layout.itemRows.count, expected.itemRows.count)
    }

    func testItemActionsAreCorrect() {
        let chars = alphaSet.rows.characters(for: .lowercased, device: .phone)
        let expected = KeyboardAction.Rows(characters: chars)
        let actions = service.itemActions(for: context)
        XCTAssertEqual(actions, expected)
    }

    func testItemActionsCanBeCased() {
        context.keyboardCase = .uppercased
        context.keyboardType = .alphabetic
        let chars = alphaSet.rows.characters(for: .uppercased, device: .phone)
        let expected = KeyboardAction.Rows(characters: chars)
        let actions = service.itemActions(for: context)
        XCTAssertEqual(actions, expected)
    }

    func testServiceCanResolveAlphabeticInputSet() {
        context.keyboardType = .alphabetic
        let set = service.inputSet(for: context)
        XCTAssertEqual(set, alphaSet)
    }

    func testServiceCanResolveNumericInputSet() {
        context.keyboardType = .numeric
        let set = service.inputSet(for: context)
        XCTAssertEqual(set, numericSet)
    }

    func testServiceCanResolveSymbolicInputSet() {
        context.keyboardType = .symbolic
        let set = service.inputSet(for: context)
        XCTAssertEqual(set, symbolicSet)
    }

    func testServiceUsesAlphabeticInputSetForOtherKeyboardTypes() {
        context.keyboardType = .emojis
        let set = service.inputSet(for: context)
        XCTAssertEqual(set, alphaSet)
    }

    func testLayoutItemsAreProperlyConfigured() {
        let result = service.itemRows(for: context)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0][0].action, .character("a"))
        XCTAssertEqual(result[0][0].edgeInsets, layoutConfig.buttonInsets)
        XCTAssertEqual(result[0][0].size.height, layoutConfig.rowHeight)
        XCTAssertEqual(result[0][0].size.width, .input)
    }

    func testKeyboardSwitcherActionForBottomInputRowIsShiftForLowercasedAlphabetic() {
        context.keyboardCase = .lowercased
        context.keyboardType = .alphabetic
        let expected = KeyboardAction.shift(.lowercased)
        let result = service.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, expected)
    }

    func testKeyboardSwitcherActionForBottomInputRowIsShiftForUppercasedAlphabetic() {
        context.keyboardCase = .uppercased
        context.keyboardType = .alphabetic
        let result = service.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, .shift(.uppercased))
    }

    func testKeyboardSwitcherActionForBottomInputRowIsShiftForNumeric() {
        context.keyboardType = .numeric
        let result = service.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, .keyboardType(.symbolic))
    }

    func testKeyboardSwitcherActionForBottomInputRowIsShiftForSymbolic() {
        context.keyboardType = .symbolic
        let result = service.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }

    func testKeyboardSwitcherActionForBottomInputRowIsShiftForUnsupportedKeybardType() {
        context.keyboardType = .emojis
        let result = service.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, .shift(context.keyboardCase))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForLowercasedAlphabetic() {
        context.keyboardCase = .lowercased
        context.keyboardType = .alphabetic
        let result = service.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForUppercasedAlphabetic() {
        context.keyboardCase = .uppercased
        context.keyboardType = .alphabetic
        let result = service.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }

    func testKeyboardSwitcherActionForBottomRowIsAlphabeticForMumeric() {
        context.keyboardType = .numeric
        let result = service.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.alphabetic))
    }

    func testKeyboardSwitcherActionForBottomRowIsAlphabeticForSymbolic() {
        context.keyboardType = .symbolic
        let result = service.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.alphabetic))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForUnsupportedKeybardType() {
        context.keyboardType = .emojis
        let result = service.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }
}
