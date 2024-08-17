//
//  KeyboardLayout+BaseService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

extension KeyboardLayout {
    
    /// This base class provides a foundation for generating
    /// layouts that are based on an ``InputSet``.
    ///
    /// The class will map the provided input sets to layout
    /// item rows, then add additional surrounding items and
    /// an additional bottom row, based on the context.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    ///
    /// See <doc:Layout-Article> for more information.
    open class BaseService: KeyboardLayoutService {

        /// Create a base layout service with input sets.
        ///
        /// - Parameters:
        ///   - alphabeticInputSet: The alphabetic input set to use.
        ///   - numericInputSet: The numeric input set to use.
        ///   - symbolicInputSet: The symbolic input set to use.
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
        open func keyboardLayout(
            for context: KeyboardContext
        ) -> KeyboardLayout {
            let rows = inputRows(for: context)
            let actions = actions(for: rows, context: context)
            let items = items(for: actions, context: context)
            return KeyboardLayout(itemRows: items)
        }
        
        
        // MARK: - Open helper functions
        
        /// Map ``InputSet`` rows to action rows.
        open func actions(
            for rows: InputSet.Rows,
            context: KeyboardContext
        ) -> KeyboardAction.Rows {
            let characters = actionCharacters(for: rows, context: context)
            return .init(characters: characters)
        }
        
        /// Map ``InputSet`` rows to action character rows.
        open func actionCharacters(
            for rows: InputSet.Rows,
            context: KeyboardContext
        ) -> [[String]] {
            switch context.keyboardType {
            case .alphabetic(let casing): rows.characters(for: casing)
            default: rows.characters()
            }
        }
        
        /// Get ``InputSet`` rows for the provided context.
        open func inputRows(
            for context: KeyboardContext
        ) -> InputSet.Rows {
            switch context.keyboardType {
            case .numeric: numericInputSet.rows
            case .symbolic: symbolicInputSet.rows
            default: alphabeticInputSet.rows
            }
        }
        
        /// Whether or not an index is the bottom row index.
        open func isBottomRowIndex(
            _ index: Int
        ) -> Bool {
            index == 3
        }
        
        /// Map ``KeyboardAction`` rows to layout items rows.
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
        
        /// Get a layout item for the provided params.
        open func item(
            for action: KeyboardAction,
            in actions: KeyboardAction.Rows,
            row: Int,
            index: Int,
            context: KeyboardContext
        ) -> KeyboardLayout.Item {
            .init(
                action: action,
                size: itemSize(for: action, row: row, index: index, context: context),
                alignment: itemAlignment(for: action, in: actions, row: row, index: index, context: context),
                edgeInsets: itemInsets(for: action, row: row, index: index, context: context)
            )
        }
        
        /// Get a layout item alignment for the provided params.
        open func itemAlignment(
            for action: KeyboardAction,
            in actions: KeyboardAction.Rows,
            row: Int,
            index: Int,
            context: KeyboardContext
        ) -> Alignment {
            .center
        }
        
        /// Get layout item insets for the provided params.
        open func itemInsets(
            for action: KeyboardAction,
            row: Int,
            index: Int,
            context: KeyboardContext
        ) -> EdgeInsets {
            switch action {
            case .characterMargin, .none: .init(all: 0)
            default: KeyboardLayout.Configuration
                    .standard(for: context)
                    .buttonInsets
            }
        }
        
        /// Get a layout item size for the provided params.
        open func itemSize(
            for action: KeyboardAction,
            row: Int,
            index: Int,
            context: KeyboardContext
        ) -> KeyboardLayout.ItemSize {
            let width = itemSizeWidth(for: action, row: row, index: index, context: context)
            let height = itemSizeHeight(for: action, row: row, index: index, context: context)
            return .init(width: width, height: height)
        }
        
        /// Get a layout item height for the provided params.
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
        
        /// Get a layout item width for the provided params.
        open func itemSizeWidth(
            for action: KeyboardAction,
            row: Int,
            index: Int,
            context: KeyboardContext
        ) -> KeyboardLayout.ItemWidth {
            switch action {
            case .character: .input
            default: .available
            }
        }
        
        /// Get a return action for the provided context.
        open func keyboardReturnAction(
            for context: KeyboardContext
        ) -> KeyboardAction {
            #if os(iOS) || os(tvOS) || os(visionOS)
            let type = context.returnKeyType
            if let type { return .primary(type) }
            #endif
            return .primary(.return)
        }
        
        /// The keyboard switcher to use on the bottom input row.
        open func keyboardSwitchActionForBottomInputRow(
            for context: KeyboardContext
        ) -> KeyboardAction? {
            switch context.keyboardType {
            case .alphabetic(let casing): .shift(currentCasing: casing)
            case .numeric: .keyboardType(.symbolic)
            case .symbolic: .keyboardType(.numeric)
            default: .shift(currentCasing: .lowercased)
            }
        }
        
        /// The keyboard switcher to use on the bottom row.
        open func keyboardSwitchActionForBottomRow(for context: KeyboardContext) -> KeyboardAction? {
            switch context.keyboardType {
            case .alphabetic: .keyboardType(.numeric)
            case .numeric: .keyboardType(.alphabetic(.auto))
            case .symbolic: .keyboardType(.alphabetic(.auto))
            default: .keyboardType(.numeric)
            }
        }
    }
}
