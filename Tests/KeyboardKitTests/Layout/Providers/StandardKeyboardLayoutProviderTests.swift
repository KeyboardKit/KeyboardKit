//
//  StandardKeyboardLayoutProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class StandardKeyboardLayoutProviderTests: XCTestCase {
    
    var inputSetProvider: MockInputSetProvider!
    var context: KeyboardContext!
    var provider: StandardKeyboardLayoutProvider!

    override func setUp() {
        context = KeyboardContext()
        inputSetProvider = MockInputSetProvider()
        inputSetProvider.alphabeticInputSetValue = AlphabeticInputSet(rows: [["a", "b", "c"], ["a", "b", "c"], ["a", "b", "c"]].map(InputSetRow.init))
        inputSetProvider.numericInputSetValue = NumericInputSet(rows: [["1", "2", "3"], ["1", "2", "3"], ["1", "2", "3"]].map(InputSetRow.init))
        inputSetProvider.symbolicInputSetValue = SymbolicInputSet(rows: [[",", ".", "-"], [",", ".", "-"], [",", ".", "-"]].map(InputSetRow.init))
        provider = StandardKeyboardLayoutProvider(
            inputSetProvider: inputSetProvider,
            dictationReplacement: .primary(.go))
    }

    func testKeyboardLayoutProviderForContextIsPhoneProviderIfContextDeviceIsPhone() {
        context.deviceType = .phone
        let result = provider.keyboardLayoutProvider(for: context)
        XCTAssertTrue(result === provider.iPhoneProvider)
    }

    func testKeyboardLayoutProviderForContextIsPhoneProviderIfContextDeviceIsPad() {
        context.deviceType = .pad
        let result = provider.keyboardLayoutProvider(for: context)
        XCTAssertTrue(result === provider.iPadProvider)
    }


    func testKeyboardLayoutForContextIsPhoneLayoutIfContentDeviceIsPhone() {
        context.deviceType = .phone
        let layout = provider.keyboardLayout(for: context)
        let phoneLayout = provider.iPhoneProvider.keyboardLayout(for: context)
        let padLayout = provider.iPadProvider.keyboardLayout(for: context)
        XCTAssertEqual(layout.itemRows, phoneLayout.itemRows)
        XCTAssertNotEqual(layout.itemRows, padLayout.itemRows)
    }

    func testKeyboardLayoutForContextIsPadLayoutIfContentDeviceIsPad() {
        context.deviceType = .pad
        let layout = provider.keyboardLayout(for: context)
        let phoneLayout = provider.iPhoneProvider.keyboardLayout(for: context)
        let padLayout = provider.iPadProvider.keyboardLayout(for: context)
        XCTAssertNotEqual(layout.itemRows, phoneLayout.itemRows)
        XCTAssertEqual(layout.itemRows, padLayout.itemRows)
    }


    func testRegisteringInputSetProviderChangesInstanceForAllProviders() {
        let newProvider = MockInputSetProvider()
        context.deviceType = .phone
        provider.register(inputSetProvider: newProvider)
        XCTAssertFalse(provider.inputSetProvider === inputSetProvider)
        XCTAssertTrue(provider.inputSetProvider === newProvider)
        XCTAssertTrue(provider.iPhoneProvider.inputSetProvider === newProvider)
        XCTAssertTrue(provider.iPadProvider.inputSetProvider === newProvider)
    }
}
