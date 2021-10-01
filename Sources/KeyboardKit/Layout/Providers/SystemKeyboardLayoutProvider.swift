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
 to get basic functionality for a system keyboard.
 */
open class SystemKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    public init(
        inputSetProvider: KeyboardInputSetProvider,
        dictationReplacement: KeyboardAction? = nil) {
        self.inputSetProvider = inputSetProvider
        self.dictationReplacement = dictationReplacement
    }

    
    public let dictationReplacement: KeyboardAction?
    public var inputSetProvider: KeyboardInputSetProvider

    
    /**
     Whether or not the alphabetic input set with an 11-11-7
     layout, which is used by e.g. `German` and other nordic
     countries. It's a richer input set than the English and
     requires adjustments for some devices.
     
     I'm not at all happy with this name, but don't know the
     proper name for this layout. If you know what it should
     be called, just create an issue or a PR and I'll merge.
     */
    public lazy var hasElevenElevenSevenAlphabeticInput: Bool = {
        inputSetProvider.alphabeticInputSet.rows.first?.count == 11
    }()
    
    
    /**
     Get a keyboard layout for the provided context.
     */
    open func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let inputs = self.inputs(for: context)
        let actions = self.actions(for: context, inputs: inputs)
        let items = self.items(for: context, actions: actions)
        return KeyboardLayout(items: items)
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
     Get keyboard actions for the provided context and inputs.
     */
    open func actions(for context: KeyboardContext, inputs: KeyboardInputRows) -> KeyboardActionRows {
        let characters = actionCharacters(for: context, inputs: inputs)
        return KeyboardActionRows(characters: characters)
    }
    
    /**
     Get keyboard action characters for the provided context
     and inputs.
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
     Get keyboard inputs for the provided context.
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
     Get keyboard layout items for the provided context and actions.
     */
    open func items(for context: KeyboardContext, actions: KeyboardActionRows) -> KeyboardLayoutItemRows {
        actions.enumerated().map { row in
            row.element.enumerated().map { action in
                item(for: context, action: action.element, row: row.offset, index: action.offset)
            }
        }
    }
    
    /**
     Get keyboard layout item for a certain action.
     */
    open func item(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutItem {
        let size = itemSize(for: context, action: action, row: row, index: index)
        let insets = itemInsets(for: context, action: action, row: row, index: index)
        return KeyboardLayoutItem(action: action, size: size, insets: insets)
    }
    
    /**
     Get the keybpard layout insets for a certain action, at
     a certain row and index.
     */
    open func itemInsets(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> EdgeInsets {
        .standardKeyboardButtonInsets(for: context.device)
    }
    
    /**
     Get the layout size for a certain keyboard action, at a
     certain row and index.
     */
    open func itemSize(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutItemSize {
        let width = itemSizeWidth(for: context, action: action, row: row, index: index)
        let height = itemSizeHeight(for: context, action: action, row: row, index: index)
        return KeyboardLayoutItemSize(width: width, height: height)
    }
    
    /**
     Get the layout height for a certain keyboard action, at
     certain row and index.
     */
    open func itemSizeHeight(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> CGFloat {
        .standardKeyboardRowHeight(for: context)
    }
    
    /**
     Get the layout width for a certain keyboard action at a
     certain row and index.
     */
    open func itemSizeWidth(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutItemWidth {
        switch action {
        case .character: return .input
        default: return .available
        }
    }
    
    /**
     The specific return action to use for a certain context.
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
     input row which is above the bottommost row. By default
     it's `shift` for `alphabetic`, `symbolic` for `numeric`
     and `numeric` for `symbolic`.
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
     keyboard row. By default it's `numeric` for `alphabetic`
     keyboards and `alphabetic` for `numeric` and `symbolic`.
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
