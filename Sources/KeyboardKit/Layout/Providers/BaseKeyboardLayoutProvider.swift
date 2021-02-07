//
//  BaseKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 This class can be inherited by any keyboard layout provider
 to get a base set of standard functionality.
 */
open class BaseKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    public init(
        inputSetProvider: KeyboardInputSetProvider,
        dictationReplacement: KeyboardAction? = nil) {
        self.inputSetProvider = inputSetProvider
        self.dictationReplacement = dictationReplacement
    }

    public let dictationReplacement: KeyboardAction?
    public let inputSetProvider: KeyboardInputSetProvider

    /**
     Get a keyboard layout for the provided context.
     */
    open func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let inputs = keyboardInputs(for: context)
        let actions = keyboardActions(for: context, inputs: inputs)
        return keyboardLayout(for: context, actions: actions)
    }
    
    
    // MARK: - Overridable helper functions
    
    /**
     Get keyboard actions for the provided context and inputs.
     */
    open func keyboardActions(for context: KeyboardContext, inputs: KeyboardInputRows) -> KeyboardActionRows {
        KeyboardActionRows(characters: inputs)
    }
    
    /**
     Get keyboard inputs for the provided context.
     */
    open func keyboardInputs(for context: KeyboardContext) -> KeyboardInputRows {
        switch context.keyboardType {
        case .alphabetic(let state):
            let rows = inputSetProvider.alphabeticInputSet().rows
            return state.isUppercased ? rows.uppercased() : rows
        case .numeric: return inputSetProvider.numericInputSet().rows
        case .symbolic: return inputSetProvider.symbolicInputSet().rows
        default: return []
        }
    }
    
    /**
     Get a keyboard layout for the provided context and actions.
     */
    open func keyboardLayout(for context: KeyboardContext, actions: KeyboardActionRows) -> KeyboardLayout {
        let items = keyboardLayoutItems(for: context, actions: actions)
        let height = CGFloat.standardKeyboardRowHeight(for: context.device)
        let insets = EdgeInsets.standardKeyboardButtonInsets(for: context.device)
        return KeyboardLayout(rows: actions, items: items, buttonHeight: height, buttonInsets: insets)
    }
    
    /**
     Get keyboard layout items for the provided context and actions.
     */
    open func keyboardLayoutItems(for context: KeyboardContext, actions: KeyboardActionRows) -> KeyboardLayoutItemRows {
        actions.enumerated().map { row in
            row.element.enumerated().map { action in
                keyboardLayoutItem(for: context, action: action.element, row: row.offset, index: action.offset)
            }
        }
    }
    
    /**
     Get keyboard layout item for a certain action.
     */
    open func keyboardLayoutItem(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutItem {
        let size = keyboardLayoutItemSize(for: context, action: action, row: row, index: index)
        let insets = keyboardLayoutItemInsets(for: context, action: action, row: row, index: index)
        return KeyboardLayoutItem(action: action, size: size, insets: insets)
    }
    
    /**
     Get the keybpard layout insets for a certain action, at
     a certain row and index.
     */
    open func keyboardLayoutItemInsets(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> EdgeInsets {
        .standardKeyboardButtonInsets(for: context.device)
    }
    
    /**
     Get the layout size for a certain keyboard action, at a
     certain row and index.
     */
    open func keyboardLayoutItemSize(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutItemSize {
        let width = keyboardLayoutItemSizeWidth(for: context, action: action, row: row, index: index)
        let height = keyboardLayoutItemSizeHeight(for: context, action: action, row: row, index: index)
        return KeyboardLayoutItemSize(width: width, height: height)
    }
    
    /**
     Get the layout height for a certain keyboard action, at
     certain row and index.
     */
    open func keyboardLayoutItemSizeHeight(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> CGFloat {
        .standardKeyboardRowHeight(for: context.device)
    }
    
    /**
     Get the layout width for a certain keyboard action at a
     certain row and index.
     */
    open func keyboardLayoutItemSizeWidth(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutWidth {
        .available
    }
}
