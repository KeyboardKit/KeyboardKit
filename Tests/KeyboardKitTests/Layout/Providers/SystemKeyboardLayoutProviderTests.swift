//
//  SystemKeyboardLayoutProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class SystemKeyboardLayoutProviderTests: QuickSpec {
    
    override func spec() {
        
        var provider: SystemKeyboardLayoutProvider!
        var inputSetProvider: MockInputSetProvider!
        var context: KeyboardContext!
        var layoutConfig: KeyboardLayoutConfiguration!
        
        beforeEach {
            context = KeyboardContext()
            layoutConfig = .standard(for: context)
            inputSetProvider = MockInputSetProvider()
            inputSetProvider.alphabeticInputSetValue = AlphabeticInputSet(rows: [["a", "b", "c"]].map(InputSetRow.init))
            inputSetProvider.numericInputSetValue = NumericInputSet(rows: [["1", "2", "3"]].map(InputSetRow.init))
            inputSetProvider.symbolicInputSetValue = SymbolicInputSet(rows: [[",", ".", "-"]].map(InputSetRow.init))
            provider = SystemKeyboardLayoutProvider(
                inputSetProvider: inputSetProvider,
                dictationReplacement: .primary(.go))
        }
        
        
        describe("keyboard layout for context") {
            
            it("is items derived from action for the input items") {
                let inputs = provider.inputRows(for: context)
                let actions = provider.actions(for: inputs, context: context)
                let items = provider.items(for: actions, context: context)
                let layout = provider.keyboardLayout(for: context)
                let expected = KeyboardLayout(itemRows: items)
                expect(layout.itemRows.count).to(equal(expected.itemRows.count))
            }
        }
        
        describe("registering input set provider") {
            
            it("changes the provider instance") {
                let newProvider = MockInputSetProvider()
                provider.register(inputSetProvider: newProvider)
                expect(provider.inputSetProvider).toNot(be(inputSetProvider))
                expect(provider.inputSetProvider).to(be(newProvider))
            }
        }
        
        
        describe("actions for context and inputs") {
            
            it("is character actions for the provided inputs") {
                let chars = [["a", "b", "c"], ["d", "e", "f"]]
                let inputs = chars.map(InputSetRow.init)
                let actions = provider.actions(for: inputs, context: context)
                let expected = KeyboardActionRows(characters: chars)
                expect(actions).to(equal(expected))
            }
            
            it("can resolve uppercased alphabetic input set") {
                context.keyboardType = .alphabetic(.uppercased)
                let chars = [["a", "b", "c"], ["d", "e", "f"]]
                let inputs = chars.map(InputSetRow.init)
                let actions = provider.actions(for: inputs, context: context)
                let expectedChars = [["A", "B", "C"], ["D", "E", "F"]]
                let expected = KeyboardActionRows(characters: expectedChars)
                expect(actions).to(equal(expected))
            }
        }
        
        describe("inputs for context") {
            
            it("can resolve alphabetic input set") {
                context.keyboardType = .alphabetic(.lowercased)
                let rows = provider.inputRows(for: context)
                expect(rows.characters()).to(equal([["a", "b", "c"]]))
            }
            
            it("can resolve numeric input set") {
                context.keyboardType = .numeric
                let rows = provider.inputRows(for: context)
                expect(rows.characters()).to(equal([["1", "2", "3"]]))
            }
            
            it("can resolve symbolic input set") {
                context.keyboardType = .symbolic
                let rows = provider.inputRows(for: context)
                expect(rows.characters()).to(equal([[",", ".", "-"]]))
            }
            
            it("returns empty rows for unsupported keybard type") {
                context.keyboardType = .emojis
                let rows = provider.inputRows(for: context)
                expect(rows.characters()).to(equal([]))
            }
        }
        
        describe("items for context and actions") {
            
            it("is character actions for the provided inputs") {
                let actions: KeyboardActionRows = [[.character("")], [.backspace]]
                let result = provider.items(for: actions, context: context)
                expect(result.count).to(equal(2))
                expect(result[0][0].action).to(equal(.character("")))
                expect(result[0][0].insets).to(equal(layoutConfig.buttonInsets))
                expect(result[0][0].size.height).to(equal(layoutConfig.rowHeight))
                expect(result[0][0].size.width).to(equal(.input))
                expect(result[1][0].action).to(equal(.backspace))
                expect(result[1][0].insets).to(equal(layoutConfig.buttonInsets))
                expect(result[1][0].size.height).to(equal(layoutConfig.rowHeight))
                expect(result[1][0].size.width).to(equal(.available))
            }
        }
        
        describe("keyboard switcher action for bottom input row") {
            
            it("is shift for lowercased alphabetic input set") {
                context.keyboardType = .alphabetic(.lowercased)
                let result = provider.keyboardSwitchActionForBottomInputRow(for: context)
                expect(result).to(equal(KeyboardAction.shift(currentState: .lowercased)))
            }
            
            it("is shift for uppercased alphabetic input set") {
                context.keyboardType = .alphabetic(.uppercased)
                let result = provider.keyboardSwitchActionForBottomInputRow(for: context)
                expect(result).to(equal(KeyboardAction.shift(currentState: .uppercased)))
            }
            
            it("is shift for numeric input set") {
                context.keyboardType = .numeric
                let result = provider.keyboardSwitchActionForBottomInputRow(for: context)
                expect(result).to(equal(.keyboardType(.symbolic)))
            }
            
            it("is shift for symbolic input set") {
                context.keyboardType = .symbolic
                let result = provider.keyboardSwitchActionForBottomInputRow(for: context)
                expect(result).to(equal(.keyboardType(.numeric)))
            }
            
            it("is nil for unsupported keybard type") {
                context.keyboardType = .emojis
                let rows = provider.inputRows(for: context)
                expect(rows.characters()).to(equal([]))
            }
        }
        
        describe("keyboard switcher action for bottom row") {
            
            it("is shift for lowercased alphabetic input set") {
                context.keyboardType = .alphabetic(.lowercased)
                let result = provider.keyboardSwitchActionForBottomRow(for: context)
                expect(result).to(equal(.keyboardType(.numeric)))
            }
            
            it("is shift for uppercased alphabetic input set") {
                context.keyboardType = .alphabetic(.uppercased)
                let result = provider.keyboardSwitchActionForBottomRow(for: context)
                expect(result).to(equal(.keyboardType(.numeric)))
            }
            
            it("is shift for numeric input set") {
                context.keyboardType = .numeric
                let result = provider.keyboardSwitchActionForBottomRow(for: context)
                expect(result).to(equal(.keyboardType(.alphabetic(.auto))))
            }
            
            it("is shift for symbolic input set") {
                context.keyboardType = .symbolic
                let result = provider.keyboardSwitchActionForBottomRow(for: context)
                expect(result).to(equal(.keyboardType(.alphabetic(.auto))))
            }
            
            it("is nil for unsupported keybard type") {
                context.keyboardType = .emojis
                let rows = provider.inputRows(for: context)
                expect(rows.characters()).to(equal([]))
            }
        }
    }
}
