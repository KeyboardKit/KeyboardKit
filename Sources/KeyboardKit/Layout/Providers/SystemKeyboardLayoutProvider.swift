//
//  SystemKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 This is a base class for any keyboard layout providers that
 need basic functionality for system keyboard layouts.

 The class is used by the ``iPadKeyboardLayoutProvider`` and
 and the ``iPhoneKeyboardLayoutProvider``, since they aim to
 create platforms-specific system keyboard layouts.
 
 Since keyboard extensions don't support `dictation` without
 having to jump through hoops (see SwiftKey) the initializer
 has a `dictationReplacement` parameter, that can be used to
 place another action where the dictation key would go.
 
 If you want to create an entirely custom layout, you should
 just implement `KeyboardLayoutProvider`.
 */
open class SystemKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    /**
     Create a system keyboard layout provider.
     
     - Parameters:
       - inputSetProvider: The input set provider to use.
     */
    public init(inputSetProvider: InputSetProvider) {
        self.inputSetProvider = inputSetProvider
    }
    
    /**
     The input set provider to use.
     */
    public var inputSetProvider: InputSetProvider
    
    
    /**
     Get a keyboard layout for a certain keyboard `context`.
     */
    open func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let inputs = self.inputRows(for: context)
        let actions = self.actions(for: inputs, context: context)
        let items = self.items(for: actions, context: context)
        return KeyboardLayout(itemRows: items)
    }

    /**
     Register a new input set provider.
     */
    open func register(inputSetProvider: InputSetProvider) {
        self.inputSetProvider = inputSetProvider
    }
    
    
    // MARK: - Overridable helper functions
    
    /**
     Get keyboard actions for the `inputs` and `context`.
     */
    open func actions(for rows: InputSetRows, context: KeyboardContext) -> KeyboardActionRows {
        let characters = actionCharacters(for: rows, context: context)
        return KeyboardActionRows(characters: characters)
    }
    
    /**
     Get actions characters for the `inputs` and `context`.
     */
    open func actionCharacters(for rows: InputSetRows, context: KeyboardContext) -> [[String]] {
        switch context.keyboardType {
        case .alphabetic(let casing): return rows.characters(for: casing)
        case .numeric: return rows.characters()
        case .symbolic: return rows.characters()
        default: return []
        }
    }
    
    /**
     Get input set rows for the provided `context`.
     */
    open func inputRows(for context: KeyboardContext) -> InputSetRows {
        switch context.keyboardType {
        case .alphabetic: return inputSetProvider.alphabeticInputSet.rows
        case .numeric: return inputSetProvider.numericInputSet.rows
        case .symbolic: return inputSetProvider.symbolicInputSet.rows
        default: return []
        }
    }
    
    /**
     Get layout item rows for the `actions` and `context`.
     */
    open func items(for actions: KeyboardActionRows, context: KeyboardContext) -> KeyboardLayoutItemRows {
        actions.enumerated().map { row in
            row.element.enumerated().map { action in
                item(for: action.element, row: row.offset, index: action.offset, context: context)
            }
        }
    }
    
    /**
     Get a layout item for the provided parameters.
     */
    open func item(for action: KeyboardAction, row: Int, index: Int, context: KeyboardContext) -> KeyboardLayoutItem {
        let size = itemSize(for: action, row: row, index: index, context: context)
        let insets = itemInsets(for: action, row: row, index: index, context: context)
        return KeyboardLayoutItem(action: action, size: size, insets: insets)
    }
    
    /**
     Get layout item insets for the provided parameters.
     */
    open func itemInsets(for action: KeyboardAction, row: Int, index: Int, context: KeyboardContext) -> EdgeInsets {
        let config = KeyboardLayoutConfiguration.standard(for: context)
        switch action {
        case .characterMargin, .none: return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        default: return config.buttonInsets
        }
    }
    
    /**
     Get a layout item size for the provided parameters.
     */
    open func itemSize(for action: KeyboardAction, row: Int, index: Int, context: KeyboardContext) -> KeyboardLayoutItemSize {
        let width = itemSizeWidth(for: action, row: row, index: index, context: context)
        let height = itemSizeHeight(for: action, row: row, index: index, context: context)
        return KeyboardLayoutItemSize(width: width, height: height)
    }
    
    /**
     Get a layout item height for the provided parameters.
     */
    open func itemSizeHeight(for action: KeyboardAction, row: Int, index: Int, context: KeyboardContext) -> CGFloat {
        let config = KeyboardLayoutConfiguration.standard(for: context)
        return config.rowHeight
    }
    
    /**
     Get a layout item width for the provided parameters.
     */
    open func itemSizeWidth(for action: KeyboardAction, row: Int, index: Int, context: KeyboardContext) -> KeyboardLayoutItemWidth {
        switch action {
        case .character: return .input
        default: return .available
        }
    }
    
    /**
     The return action to use for the provided `context`.
     */
    open func keyboardReturnAction(for context: KeyboardContext) -> KeyboardAction {
        #if os(iOS) || os(tvOS)
        return context.textDocumentProxy.returnKeyType?.keyboardAction ?? .primary(.return)
        #else
        return .primary(.return)
        #endif
    }
    
    /**
     The keyboard switch action that should be on the bottom
     input row, which is the row above the bottommost row.
     */
    open func keyboardSwitchActionForBottomInputRow(for context: KeyboardContext) -> KeyboardAction? {
        switch context.keyboardType {
        case .alphabetic(let casing): return .shift(currentCasing: casing)
        case .numeric: return .keyboardType(.symbolic)
        case .symbolic: return .keyboardType(.numeric)
        default: return nil
        }
    }
    
    /**
     The keyboard switch action that should be on the bottom
     keyboard row, which is the row with the space button.
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
