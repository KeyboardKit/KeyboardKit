//
//  BaseKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 This is a base class for custom keyboard layout providers.
 
 You can inherit this class to get access to convenient base
 functionality, then override any parts you want to change.

 The class is used by the ``iPadKeyboardLayoutProvider`` and
 the ``iPhoneKeyboardLayoutProvider`` which provide specific
 layouts for the various platforms on top of this base class.
 */
open class BaseKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    /**
     Create a system keyboard layout provider.
     
     - Parameters:
       - alphabeticInputSet: The alphabetic input set to use.
       - numericInputSet: The numeric input set to use.
       - symbolicInputSet: The symbolic input set to use.
     */
    public init(
        alphabeticInputSet: InputSet,
        numericInputSet: InputSet,
        symbolicInputSet: InputSet
    ) {
        self.alphabeticInputSet = alphabeticInputSet
        self.numericInputSet = numericInputSet
        self.symbolicInputSet = symbolicInputSet
    }
    
    
    /// The alphabetic input set to use.
    public var alphabeticInputSet: InputSet
    
    /// The numeric input set to use.
    public var numericInputSet: InputSet
    
    /// The symbolic input set to use.
    public var symbolicInputSet: InputSet
    
    
    /// Get a keyboard layout for the provided context.
    open func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let inputs = self.inputRows(for: context)
        let actions = self.actions(for: inputs, context: context)
        let items = self.items(for: actions, context: context)
        return KeyboardLayout(itemRows: items)
    }
    
    
    // MARK: - Overridable helper functions
    
    /// Get actions for the provided rows and context.
    open func actions(
        for rows: InputSet.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Rows {
        let characters = actionCharacters(for: rows, context: context)
        return .init(characters: characters)
    }
    
    /// Get action chars for the provided rows and context.
    open func actionCharacters(
        for rows: InputSet.Rows,
        context: KeyboardContext
    ) -> [[String]] {
        switch context.keyboardType {
        case .alphabetic(let casing): rows.characters(for: casing)
        default: rows.characters()
        }
    }
    
    /// Get input rows for the provided context.
    open func inputRows(
        for context: KeyboardContext
    ) -> InputSet.Rows {
        switch context.keyboardType {
        case .numeric: numericInputSet.rows
        case .symbolic: symbolicInputSet.rows
        default: alphabeticInputSet.rows
        }
    }
    
    /// Get item rows for the provided actions and context.
    open func items(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardLayout.ItemRows {
        actions.enumerated().map { row in
            row.element.enumerated().map { action in
                item(
                    for: action.element,
                    in: actions,
                    row: row.offset,
                    index: action.offset,
                    context: context
                )
            }
        }
    }
    
    /// Get a layout item for the provided parameters.
    open func item(
        for action: KeyboardAction,
        in actions: KeyboardAction.Rows,
        row: Int,
        index: Int,
        context: KeyboardContext
    ) -> KeyboardLayout.Item {
        KeyboardLayout.Item(
            action: action,
            size: itemSize(for: action, row: row, index: index, context: context),
            alignment: itemAlignment(for: action, in: actions, row: row, index: index, context: context),
            edgeInsets: itemInsets(for: action, row: row, index: index, context: context)
        )
    }
    
    /// Get a layout item for the provided parameters.
    open func itemAlignment(
        for action: KeyboardAction,
        in actions: KeyboardAction.Rows,
        row: Int,
        index: Int,
        context: KeyboardContext
    ) -> Alignment {
        .center
    }
    
    /// Get layout item insets for the provided parameters.
    open func itemInsets(
        for action: KeyboardAction,
        row: Int,
        index: Int,
        context: KeyboardContext
    ) -> EdgeInsets {
        switch action {
        case .characterMargin, .none: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        default: KeyboardLayout.Configuration
                .standard(for: context)
                .buttonInsets
        }
    }
    
    /// Get a layout item size for the provided parameters.
    open func itemSize(
        for action: KeyboardAction,
        row: Int,
        index: Int,
        context: KeyboardContext
    ) -> KeyboardLayout.ItemSize {
        let width = itemSizeWidth(for: action, row: row, index: index, context: context)
        let height = itemSizeHeight(for: action, row: row, index: index, context: context)
        return KeyboardLayout.ItemSize(width: width, height: height)
    }
    
    /// Get a layout item height for the provided parameters.
    open func itemSizeHeight(
        for action: KeyboardAction,
        row: Int,
        index: Int,
        context: KeyboardContext
    ) -> CGFloat {
        KeyboardLayout.Configuration
            .standard(for: context)
            .rowHeight
    }
    
    /// Get a layout item width for the provided parameters.
    open func itemSizeWidth(
        for action: KeyboardAction,
        row: Int,
        index: Int,
        context: KeyboardContext
    ) -> KeyboardLayout.ItemWidth {
        switch action {
        case .character: return .input
        default: return .available
        }
    }
    
    /// The return action to use for the provided context.
    open func keyboardReturnAction(for context: KeyboardContext) -> KeyboardAction {
        #if os(iOS) || os(tvOS)
        let proxy = context.textDocumentProxy
        let returnType = proxy.returnKeyType?.keyboardReturnKeyType
        if let returnType { return .primary(returnType) }
        #endif
        return .primary(.return)
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
        default: return .shift(currentCasing: .lowercased)
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
        default: return .keyboardType(.numeric)
        }
    }
}
