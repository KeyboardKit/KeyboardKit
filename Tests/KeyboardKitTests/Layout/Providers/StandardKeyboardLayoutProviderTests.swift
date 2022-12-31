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
    var keyboardContext: KeyboardContext!
    var provider: StandardKeyboardLayoutProvider!

    override func setUp() {
        keyboardContext = KeyboardContext()
        inputSetProvider = MockInputSetProvider()
        inputSetProvider.alphabeticInputSetValue = AlphabeticInputSet(rows: [["a", "b", "c"], ["a", "b", "c"], ["a", "b", "c"]].map(InputSetRow.init(chars:)))
        inputSetProvider.numericInputSetValue = NumericInputSet(rows: [["1", "2", "3"], ["1", "2", "3"], ["1", "2", "3"]].map(InputSetRow.init(chars:)))
        inputSetProvider.symbolicInputSetValue = SymbolicInputSet(rows: [[",", ".", "-"], [",", ".", "-"], [",", ".", "-"]].map(InputSetRow.init(chars:)))
        provider = StandardKeyboardLayoutProvider(
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider)
    }

    func testKeyboardLayoutProviderForContextIsPhoneProviderIfContextDeviceIsPhone() {
        keyboardContext.deviceType = .phone
        let result = provider.keyboardLayoutProvider(for: keyboardContext)
        XCTAssertTrue(result === provider.iPhoneProvider)
    }

    func testKeyboardLayoutProviderForContextIsPhoneProviderIfContextDeviceIsPad() {
        keyboardContext.deviceType = .pad
        let result = provider.keyboardLayoutProvider(for: keyboardContext)
        XCTAssertTrue(result === provider.iPadProvider)
    }


    func testKeyboardLayoutForContextIsPhoneLayoutIfContentDeviceIsPhone() {
        keyboardContext.deviceType = .phone
        let layout = provider.keyboardLayout(for: keyboardContext)
        let phoneLayout = provider.iPhoneProvider.keyboardLayout(for: keyboardContext)
        let padLayout = provider.iPadProvider.keyboardLayout(for: keyboardContext)
        XCTAssertEqual(layout.itemRows, phoneLayout.itemRows)
        XCTAssertNotEqual(layout.itemRows, padLayout.itemRows)
    }

    func testKeyboardLayoutForContextIsPadLayoutIfContentDeviceIsPad() {
        keyboardContext.deviceType = .pad
        let layout = provider.keyboardLayout(for: keyboardContext)
        let phoneLayout = provider.iPhoneProvider.keyboardLayout(for: keyboardContext)
        let padLayout = provider.iPadProvider.keyboardLayout(for: keyboardContext)
        XCTAssertNotEqual(layout.itemRows, phoneLayout.itemRows)
        XCTAssertEqual(layout.itemRows, padLayout.itemRows)
    }


    func testRegisteringInputSetProviderChangesInstanceForAllProviders() {
        let newProvider = MockInputSetProvider()
        keyboardContext.deviceType = .phone
        provider.register(inputSetProvider: newProvider)
        XCTAssertFalse(provider.inputSetProvider === inputSetProvider)
        XCTAssertTrue(provider.inputSetProvider === newProvider)
        XCTAssertTrue(provider.iPhoneProvider.inputSetProvider === newProvider)
        XCTAssertTrue(provider.iPadProvider.inputSetProvider === newProvider)
    }
}
