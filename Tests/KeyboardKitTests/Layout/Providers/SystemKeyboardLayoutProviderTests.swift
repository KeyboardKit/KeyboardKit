//
//  SystemKeyboardLayoutProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class SystemKeyboardLayoutProviderTests: XCTestCase {

    var provider: SystemKeyboardLayoutProvider!
    var inputSetProvider: MockInputSetProvider!
    var context: KeyboardContext!
    var layoutConfig: KeyboardLayoutConfiguration!

    override func setUp() {
        context = KeyboardContext()
        layoutConfig = .standard(for: context)
        inputSetProvider = MockInputSetProvider()
        inputSetProvider.alphabeticInputSetValue = AlphabeticInputSet(rows: [["a", "b", "c"]].map(InputSetRow.init(chars:)))
        inputSetProvider.numericInputSetValue = NumericInputSet(rows: [["1", "2", "3"]].map(InputSetRow.init(chars:)))
        inputSetProvider.symbolicInputSetValue = SymbolicInputSet(rows: [[",", ".", "-"]].map(InputSetRow.init(chars:)))
        provider = SystemKeyboardLayoutProvider(inputSetProvider: inputSetProvider)
    }


    func testKeyboardLayoutContainsItemsFromInputItemActions() {
        let inputs = provider.inputRows(for: context)
        let actions = provider.actions(for: inputs, context: context)
        let items = provider.items(for: actions, context: context)
        let layout = provider.keyboardLayout(for: context)
        let expected = KeyboardLayout(itemRows: items)
        XCTAssertEqual(layout.itemRows.count, expected.itemRows.count)
    }


    func testRegisteringInputSetProviderChangesTheProvider() {
        let newProvider = MockInputSetProvider()
        provider.register(inputSetProvider: newProvider)
        XCTAssertFalse(provider.inputSetProvider === inputSetProvider)
        XCTAssertTrue(provider.inputSetProvider === newProvider)
    }


    func testActionsForContextAndInputsAreCharacterActionsForTheProvidedInputs() {
        let chars = [["a", "b", "c"], ["d", "e", "f"]]
        let inputs = chars.map(InputSetRow.init(chars:))
        let actions = provider.actions(for: inputs, context: context)
        let expected = KeyboardActionRows(characters: chars)
        XCTAssertEqual(actions, expected)
    }

    func testActionsForContextAndInputsCanResolveUppercasedAlphabeticInputSet() {
        context.keyboardType = .alphabetic(.uppercased)
        let chars = [["a", "b", "c"], ["d", "e", "f"]]
        let inputs = chars.map(InputSetRow.init(chars:))
        let actions = provider.actions(for: inputs, context: context)
        let expectedChars = [["A", "B", "C"], ["D", "E", "F"]]
        let expected = KeyboardActionRows(characters: expectedChars)
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

    func testInputsForContextReturnsEmptyRowsForUnsupportedKeybardType() {
        context.keyboardType = .emojis
        let rows = provider.inputRows(for: context)
        XCTAssertEqual(rows.characters(), [])
    }


    func testItemsForContextAndActionsAreCharacterActionsForTheProvidedInputs() {
        let actions: KeyboardActionRows = [[.character("")], [.backspace]]
        let result = provider.items(for: actions, context: context)
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0][0].action, .character(""))
        XCTAssertEqual(result[0][0].insets, layoutConfig.buttonInsets)
        XCTAssertEqual(result[0][0].size.height, layoutConfig.rowHeight)
        XCTAssertEqual(result[0][0].size.width, .input)
        XCTAssertEqual(result[1][0].action, .backspace)
        XCTAssertEqual(result[1][0].insets, layoutConfig.buttonInsets)
        XCTAssertEqual(result[1][0].size.height, layoutConfig.rowHeight)
        XCTAssertEqual(result[1][0].size.width, .available)
    }


    func testKeyboardSwitcherActionForBottomInputRowIsShiftForLowercasedAlphabetic() {
        context.keyboardType = .alphabetic(.lowercased)
        let result = provider.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, KeyboardAction.shift(currentState: .lowercased))
    }

    func testKeyboardSwitcherActionForBottomInputRowIsShiftForUppercasedAlphabetic() {
        context.keyboardType = .alphabetic(.uppercased)
        let result = provider.keyboardSwitchActionForBottomInputRow(for: context)
        XCTAssertEqual(result, KeyboardAction.shift(currentState: .uppercased))
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

    func testKeyboardSwitcherActionForBottomInputRowIsNilForUnsupportedKeybardType() {
        context.keyboardType = .emojis
        let rows = provider.inputRows(for: context)
        XCTAssertEqual(rows.characters(), [])
    }


    func testKeyboardSwitcherActionForBottomRowIsShiftForForLowercasedAlphabetic() {
        context.keyboardType = .alphabetic(.lowercased)
        let result = provider.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForForUppercasedAlphabetic() {
        context.keyboardType = .alphabetic(.uppercased)
        let result = provider.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.numeric))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForForNumeric() {
        context.keyboardType = .numeric
        let result = provider.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.alphabetic(.auto)))
    }

    func testKeyboardSwitcherActionForBottomRowIsShiftForForSymbolic() {
        context.keyboardType = .symbolic
        let result = provider.keyboardSwitchActionForBottomRow(for: context)
        XCTAssertEqual(result, .keyboardType(.alphabetic(.auto)))
    }

    func testKeyboardSwitcherActionForBottomRowIsNilForUnsupportedKeybardType() {
        context.keyboardType = .emojis
        let rows = provider.inputRows(for: context)
        XCTAssertEqual(rows.characters(), [])
    }
}
