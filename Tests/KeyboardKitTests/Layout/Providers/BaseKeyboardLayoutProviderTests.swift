//
//  BaseKeyboardLayoutProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class BaseKeyboardLayoutProviderTests: XCTestCase {

    var provider: BaseKeyboardLayoutProvider!
    var context: KeyboardContext!
    var layoutConfig: KeyboardLayout.Configuration!

    override func setUp() {
        context = KeyboardContext()
        layoutConfig = .standard(for: context)
        provider = BaseKeyboardLayoutProvider(
            alphabeticInputSet: InputSet(rows: [["a", "b", "c"]].map(InputSet.Row.init(chars:))),
            numericInputSet: InputSet(rows: [["1", "2", "3"]].map(InputSet.Row.init(chars:))),
            symbolicInputSet: InputSet(rows: [[",", ".", "-"]].map(InputSet.Row.init(chars:)))
        )
    }


    func testKeyboardLayoutContainsItemsFromInputItemActions() {
        let inputs = provider.inputRows(for: context)
        let actions = provider.actions(for: inputs, context: context)
        let items = provider.items(for: actions, context: context)
        let layout = provider.keyboardLayout(for: context)
        let expected = KeyboardLayout(itemRows: items)
        XCTAssertEqual(layout.itemRows.count, expected.itemRows.count)
    }


    func testActionsForContextAndInputsAreCharacterActionsForTheProvidedInputs() {
        let chars = [["a", "b", "c"], ["d", "e", "f"]]
        let inputs = chars.map(InputSet.Row.init(chars:))
        let actions = provider.actions(for: inputs, context: context)
        let expected = KeyboardAction.Rows(characters: chars)
        XCTAssertEqual(actions, expected)
    }

    func testActionsForContextAndInputsCanResolveUppercasedAlphabeticInputSet() {
        context.keyboardType = .alphabetic(.uppercased)
        let chars = [["a", "b", "c"], ["d", "e", "f"]]
        let inputs = chars.map(InputSet.Row.init(chars:))
        let actions = provider.actions(for: inputs, context: context)
        let expectedChars = [["A", "B", "C"], ["D", "E", "F"]]
        let expected = KeyboardAction.Rows(characters: expectedChars)
        XCTAssertEqual(actions, expected)
    }


    func testInputsForContextCanResolveAlphabeticInputSet() {
        context.keyboardType = .alphabetic(.lowercased)
        let rows = provider.inputRows(for: context)
        XCTAssertEqual(rows.characters(), [["a", "b", "c"]])
    }

    func testInputsForContextCanResolveNumericInputSet() {
        context.keyboardType = .numeric
        let rows = provider.inputRows(for: context)
        XCTAssertEqual(rows.characters(), [["1", "2", "3"]])
    }

    func testInputsForContextCanResolveSymbolicInputSet() {
        context.keyboardType = .symbolic
        let rows = provider.inputRows(for: context)
        XCTAssertEqual(rows.characters(), [[",", ".", "-"]])
    }

    func testInputsForContextReturnsAlphabeticInputSetForUnsupportedKeybardType() {
        context.keyboardType = .emojis
        let rows = provider.inputRows(for: context)
        XCTAssertEqual(rows.characters(), [["a", "b", "c"]])
    }


    func testItemsForContextAndActionsAreCharacterActionsForTheProvidedInputs() {
        let actions: KeyboardAction.Rows = [[.character("")], [.backspace]]
        let result = provider.items(for: actions, context: context)
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
        let result = provider.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, .shift(currentCasing: .lowercased))
    }

    func testKeyboardSwitcherActionForBottomInputRowIsShiftForUppercasedAlphabetic() {
        context.keyboardType = .alphabetic(.uppercased)
        let result = provider.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, .shift(currentCasing: .uppercased))
    }

    func testKeyboardSwitcherActionForBottomInputRowIsShiftForNumeric() {
        context.keyboardType = .numeric
        let result = provider.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, .keyboardType(.symbolic))
    }

    func testKeyboardSwitcherActionForBottomInputRowIsShiftForSymbolic() {
        context.keyboardType = .symbolic
        let result = provider.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }

    func testKeyboardSwitcherActionForBottomInputRowIsShiftForUnsupportedKeybardType() {
        context.keyboardType = .emojis
        let result = provider.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, .shift(currentCasing: .lowercased))
    }


    func testKeyboardSwitcherActionForBottomRowIsShiftForLowercasedAlphabetic() {
        context.keyboardType = .alphabetic(.lowercased)
        let result = provider.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForUppercasedAlphabetic() {
        context.keyboardType = .alphabetic(.uppercased)
        let result = provider.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForNumeric() {
        context.keyboardType = .numeric
        let result = provider.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.alphabetic(.auto)))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForSymbolic() {
        context.keyboardType = .symbolic
        let result = provider.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.alphabetic(.auto)))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForUnsupportedKeybardType() {
        context.keyboardType = .emojis
        let result = provider.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }
}
