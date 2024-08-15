//
//  KeyboardLayout+BaseServiceTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLayout_BaseServiceTests: XCTestCase {

    var service: KeyboardLayout.BaseService!
    var context: KeyboardContext!
    var layoutConfig: KeyboardLayout.Configuration!

    override func setUp() {
        context = .init()
        layoutConfig = .standard(for: context)
        service = .init(
            alphabeticInputSet: InputSet(rows: [["a", "b", "c"]].map(InputSet.Row.init(chars:))),
            numericInputSet: InputSet(rows: [["1", "2", "3"]].map(InputSet.Row.init(chars:))),
            symbolicInputSet: InputSet(rows: [[",", ".", "-"]].map(InputSet.Row.init(chars:)))
        )
    }


    func testKeyboardLayoutContainsItemsFromInputItemActions() {
        let inputs = service.inputRows(for: context)
        let actions = service.actions(for: inputs, context: context)
        let items = service.items(for: actions, context: context)
        let layout = service.keyboardLayout(for: context)
        let expected = KeyboardLayout(itemRows: items)
        XCTAssertEqual(layout.itemRows.count, expected.itemRows.count)
    }


    func testActionsForContextAndInputsAreCharacterActionsForTheProvidedInputs() {
        let chars = [["a", "b", "c"], ["d", "e", "f"]]
        let inputs = chars.map(InputSet.Row.init(chars:))
        let actions = service.actions(for: inputs, context: context)
        let expected = KeyboardAction.Rows(characters: chars)
        XCTAssertEqual(actions, expected)
    }

    func testActionsForContextAndInputsCanResolveUppercasedAlphabeticInputSet() {
        context.keyboardType = .alphabetic(.uppercased)
        let chars = [["a", "b", "c"], ["d", "e", "f"]]
        let inputs = chars.map(InputSet.Row.init(chars:))
        let actions = service.actions(for: inputs, context: context)
        let expectedChars = [["A", "B", "C"], ["D", "E", "F"]]
        let expected = KeyboardAction.Rows(characters: expectedChars)
        XCTAssertEqual(actions, expected)
    }


    func testInputsForContextCanResolveAlphabeticInputSet() {
        context.keyboardType = .alphabetic(.lowercased)
        let rows = service.inputRows(for: context)
        XCTAssertEqual(rows.characters(), [["a", "b", "c"]])
    }

    func testInputsForContextCanResolveNumericInputSet() {
        context.keyboardType = .numeric
        let rows = service.inputRows(for: context)
        XCTAssertEqual(rows.characters(), [["1", "2", "3"]])
    }

    func testInputsForContextCanResolveSymbolicInputSet() {
        context.keyboardType = .symbolic
        let rows = service.inputRows(for: context)
        XCTAssertEqual(rows.characters(), [[",", ".", "-"]])
    }

    func testInputsForContextReturnsAlphabeticInputSetForUnsupportedKeybardType() {
        context.keyboardType = .emojis
        let rows = service.inputRows(for: context)
        XCTAssertEqual(rows.characters(), [["a", "b", "c"]])
    }


    func testItemsForContextAndActionsAreCharacterActionsForTheProvidedInputs() {
        let actions: KeyboardAction.Rows = [[.character("")], [.backspace]]
        let result = service.items(for: actions, context: context)
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0][0].action, .character(""))
        XCTAssertEqual(result[0][0].edgeInsets, layoutConfig.buttonInsets)
        XCTAssertEqual(result[0][0].size.height, layoutConfig.rowHeight)
        XCTAssertEqual(result[0][0].size.width, .input)
        XCTAssertEqual(result[1][0].action, .backspace)
        XCTAssertEqual(result[1][0].edgeInsets, layoutConfig.buttonInsets)
        XCTAssertEqual(result[1][0].size.height, layoutConfig.rowHeight)
        XCTAssertEqual(result[1][0].size.width, .available)
    }


    func testKeyboardSwitcherActionForBottomInputRowIsShiftForLowercasedAlphabetic() {
        context.keyboardType = .alphabetic(.lowercased)
        let result = service.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, .shift(currentCasing: .lowercased))
    }

    func testKeyboardSwitcherActionForBottomInputRowIsShiftForUppercasedAlphabetic() {
        context.keyboardType = .alphabetic(.uppercased)
        let result = service.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, .shift(currentCasing: .uppercased))
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
        XCTAssertEqual(result, .shift(currentCasing: .lowercased))
    }


    func testKeyboardSwitcherActionForBottomRowIsShiftForLowercasedAlphabetic() {
        context.keyboardType = .alphabetic(.lowercased)
        let result = service.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForUppercasedAlphabetic() {
        context.keyboardType = .alphabetic(.uppercased)
        let result = service.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForNumeric() {
        context.keyboardType = .numeric
        let result = service.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.alphabetic(.auto)))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForSymbolic() {
        context.keyboardType = .symbolic
        let result = service.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.alphabetic(.auto)))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForUnsupportedKeybardType() {
        context.keyboardType = .emojis
        let result = service.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }
}
