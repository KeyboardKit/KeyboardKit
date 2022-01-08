//
//  SystemKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 This class can be inherited by any keyboard layout provider
 that needs basic functionality for creating system keyboard
 layouts that depend on system-specific rules.
 
 The class will use an `KeyboardInputSetProvider` to get the
 input set, which is then used to create the complete layout.
 Since native keyboards generally do not support `dictation`,
 there is a `dictationReplacement` that can be used to place
 another action where the dictation key would otherwise go.
 
 If you want to create an entirely custom layout, you should
 just implement `KeyboardLayoutProvider`.
 
 `TODO` I'm not at all happy with the `hasXXXAlphabeticInput`
 names. If you know how to improve it, please do let me know.
 */
open class SystemKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    /**
     Create a system keyboard layout provider.
     
     - Parameters:
       - inputSetProvider: The input set provider to use.
       - dictationReplacement: An optional dictation replacement action.
     */
    public init(
        inputSetProvider: KeyboardInputSetProvider,
        dictationReplacement: KeyboardAction? = nil) {
        self.inputSetProvider = inputSetProvider
        self.dictationReplacement = dictationReplacement
    }

    
    /**
     An optional dictation replacement action.
     */
    public let dictationReplacement: KeyboardAction?
    
    /**
     The input set provider to use.
     */
    public var inputSetProvider: KeyboardInputSetProvider
    
    
    /**
     The number of alphabetic inputs on each input row.
     */
    public var alphabeticInputCount: [Int] {
        inputSetProvider.alphabeticInputSet.rows.map { $0.count }
    }
    
    /**
     Whether or not the alphabetic input set uses an 11-11-X
     layout, which is used by e.g. `German` keyboards.
     */
    public var hasElevenElevenAlphabeticInput: Bool {
        alphabeticInputCount.prefix(2) == [11, 11]
    }

    /**
     Whether or not the alphabetic input set uses an 11-10-9
     layout, which is used by `Turkish` iPhone keyboards.
     */
    public var hasTwelveElevenNineAlphabeticInput: Bool {
        alphabeticInputCount.prefix(3) == [12, 11, 9]
    }
    
    /**
     Whether or not the context keyboard type is alphabetic.
     */
    public func isAlphabetic(_ context: KeyboardContext) -> Bool {
        context.keyboardType.isAlphabetic
    }
    
    /**
     Whether or not to use an Arabic alphabetic keyboard.
     */
    public func isArabic(_ context: KeyboardContext) -> Bool {
        context.locale.identifier == "ar"
    }
    
    /**
     Whether or not to use an Arabic alphabetic keyboard.
     */
    public func isArabicAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && isArabic(context)
    }
    
    /**
     Whether or not to use an Belarusian alphabetic keyboard.
     */
    public func isBelarusianAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && context.locale.identifier == "be"
    }
    
    /**
     Whether or not to use an Czech alphabetic keyboard.
     */
    public func isCzechAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && context.locale.identifier == "cs"
    }
    
    /**
     Whether or not to use an Persian alphabetic keyboard.
     */
    public func isPersianAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && context.locale.identifier == "fa"
    }
    
    /**
     Whether or not to use an Russian alphabetic keyboard.
     */
    public func isRussianAlphabetic(_ context: KeyboardContext) -> Bool {
        isAlphabetic(context) && context.locale.identifier == "ru"
    }
    
    /**
     Get a keyboard layout for a certain keyboard `context`.
     */
    open func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let inputs = self.inputs(for: context)
        let actions = self.actions(for: context, inputs: inputs)
        let items = self.items(for: context, actions: actions)
        return KeyboardLayout(itemRows: items)
    }
    
    /**
     Register a new input set provider. This will affect the
     keyboard layout that is provided by this class.
     */
    open func register(inputSetProvider: KeyboardInputSetProvider) {
        self.inputSetProvider = inputSetProvider
    }
    
    
    // MARK: - Overridable helper functions
    
    /**
     Get keyboard actions for the provided `context` and the
     provided keyboard `inputs`.
     */
    open func actions(for context: KeyboardContext, inputs: KeyboardInputRows) -> KeyboardActionRows {
        let characters = actionCharacters(for: context, inputs: inputs)
        return KeyboardActionRows(characters: characters)
    }
    
    /**
     Get a keyboard action character matrix for the provided
     `context` and `inputs`.
     */
    open func actionCharacters(for context: KeyboardContext, inputs: KeyboardInputRows) -> [[String]] {
        switch context.keyboardType {
        case .alphabetic(let casing): return inputs.characters(for: casing)
        case .numeric: return inputs.characters()
        case .symbolic: return inputs.characters()
        default: return []
        }
    }
    
    /**
     Get keyboard inputs for the provided `context`.
     */
    open func inputs(for context: KeyboardContext) -> KeyboardInputRows {
        switch context.keyboardType {
        case .alphabetic: return inputSetProvider.alphabeticInputSet.rows
        case .numeric: return inputSetProvider.numericInputSet.rows
        case .symbolic: return inputSetProvider.symbolicInputSet.rows
        default: return []
        }
    }
    
    /**
     Get keyboard layout item rows for the provided `context`
     and `actions`.
     */
    open func items(for context: KeyboardContext, actions: KeyboardActionRows) -> KeyboardLayoutItemRows {
        actions.enumerated().map { row in
            row.element.enumerated().map { action in
                item(for: context, action: action.element, row: row.offset, index: action.offset)
            }
        }
    }
    
    /**
     Get a keyboard layout item for the provided parameters.
     */
    open func item(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutItem {
        let size = itemSize(for: context, action: action, row: row, index: index)
        let insets = itemInsets(for: context, action: action, row: row, index: index)
        return KeyboardLayoutItem(action: action, size: size, insets: insets)
    }
    
    /**
     Get keyboard item insets for the provided parameters.
     */
    open func itemInsets(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> EdgeInsets {
        let config = KeyboardLayoutConfiguration.standard(for: context)
        return config.buttonInsets
    }
    
    /**
     Get a keyboard item size for the provided parameters.
     */
    open func itemSize(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutItemSize {
        let width = itemSizeWidth(for: context, action: action, row: row, index: index)
        let height = itemSizeHeight(for: context, action: action, row: row, index: index)
        return KeyboardLayoutItemSize(width: width, height: height)
    }
    
    /**
     Get the keyboard layout item height of an `action`, for
     the provided `context`, `row` and row `index`.
     */
    open func itemSizeHeight(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> CGFloat {
        let config = KeyboardLayoutConfiguration.standard(for: context)
        return config.rowHeight
    }
    
    /**
     Get the keyboard layout item width of a certain `action`
     for the provided `context`, `row` and row `index`.
     */
    open func itemSizeWidth(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutItemWidth {
        switch action {
        case .character: return .input
        default: return .available
        }
    }
    
    /**
     The return action to use for the provided `context`.
     */
    open func keyboardReturnAction(for context: KeyboardContext) -> KeyboardAction {
        let type = context.textDocumentProxy.returnKeyType
        switch type {
        case .done: return .primary(.done)
        case .go: return .primary(.go)
        case .search: return .primary(.search)
        default: return .return
        }
    }
    
    /**
     The keyboard switch action that should be on the bottom
     input row, which is above the bottommost row.
     */
    open func keyboardSwitchActionForBottomInputRow(for context: KeyboardContext) -> KeyboardAction? {
        switch context.keyboardType {
        case .alphabetic(let state): return .shift(currentState: state)
        case .numeric: return .keyboardType(.symbolic)
        case .symbolic: return .keyboardType(.numeric)
        default: return nil
        }
    }
    
    /**
     The keyboard switch action that should be on the bottom
     keyboard row.
     */
    open func keyboardSwitchActionForBottomRow(for context: KeyboardContext) -> KeyboardAction? {
        switch context.keyboardType {
        case .alphabetic: return .keyboardType(.numeric)
        case .numeric: return .keyboardType(.alphabetic(.auto))
        case .symbolic: return .keyboardType(.alphabetic(.auto))
        default: return nil
        }
    }
}
