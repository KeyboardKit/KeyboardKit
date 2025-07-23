//
//  KeyboardLayout+BaseLayoutService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

extension KeyboardLayout {

    /// > Deprecated: These services will be removed in 10.0.
    ///
    /// This base class provides a foundation for generating
    /// layouts, based on ``KeyboardLayout/InputSet`` values.
    open class BaseLayoutService: KeyboardLayoutService {

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
            KeyboardLayout(
                itemRows: itemRows(for: context),
                deviceConfiguration: .standard(for: context),
                inputToolbarInputSet: inputSetForInputToolbar(with: context)
            )
        }


        // MARK: - Input Sets

        /// The ``KeyboardLayout/InputSet`` to apply for the
        /// provided context.
        open func inputSet(
            for context: KeyboardContext
        ) -> InputSet {
            switch context.keyboardType {
            case .numeric: numericInputSet
            case .symbolic: symbolicInputSet
            default: alphabeticInputSet
            }
        }
        
        @available(*, deprecated, renamed: "inputSetForInputToolbar(with:)")
        open func inputSetForNumberInputToolbar(
            with context: KeyboardContext
        ) -> InputSet {
            inputSetForInputToolbar(with: context)
        }
        
        /// The ``KeyboardLayout/InputSet`` to use to set up
        /// an optional top input toolbar, if any.
        open func inputSetForInputToolbar(
            with context: KeyboardContext
        ) -> InputSet {
            switch context.keyboardType {
            case .numeric: symbolicInputSet
            default: numericInputSet
            }
        }


        // MARK: - Layout Builders

        /// The input characters to convert to input keys.
        open func inputCharacters(
            for context: KeyboardContext
        ) -> [[String]] {
            let rows = inputSet(for: context).rows
            return rows.characters(
                for: context.keyboardCase,
                device: context.deviceTypeForKeyboard
            )
        }

        /// The input actions to convert to layout actions.
        open func inputActions(
            for context: KeyboardContext
        ) -> KeyboardAction.Rows {
            .init(characters: inputCharacters(for: context))
        }

        /// The actions to convert to layout items.
        open func itemActions(
            for context: KeyboardContext
        ) -> KeyboardAction.Rows {
            inputActions(for: context)
        }

        /// The item rows to use for the provided context.
        open func itemRows(
            for context: KeyboardContext
        ) -> KeyboardLayout.ItemRows {
            let actions = itemActions(for: context)
            return actions.enumerated().map { row in
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

        // MARK: - Item builders

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
            default: KeyboardLayout.DeviceConfiguration
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
            KeyboardLayout.DeviceConfiguration
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


        // MARK: - Button Builders

        /// Get a return action for the provided context.
        open func keyboardReturnAction(
            for context: KeyboardContext
        ) -> KeyboardAction {
            if context.keyboardType == .emojiSearch { return .primary(.done) }
            let type = context.returnKeyType
            if let type { return .primary(type) }
            return .primary(.return)
        }

        /// The keyboard switcher to use on the bottom input row.
        open func keyboardSwitchActionForBottomInputRow(
            for context: KeyboardContext
        ) -> KeyboardAction? {
            switch context.keyboardType {
            case .numeric: .keyboardType(.symbolic)
            case .symbolic: .keyboardType(.numeric)
            default: .shift(context.keyboardCase)
            }
        }

        /// The keyboard switcher to use on the bottom row.
        open func keyboardSwitchActionForBottomRow(for context: KeyboardContext) -> KeyboardAction? {
            switch context.keyboardType {
            case .alphabetic: .keyboardType(.numeric)
            case .numeric: .keyboardType(.alphabetic)
            case .symbolic: .keyboardType(.alphabetic)
            default: .keyboardType(.numeric)
            }
        }
    }
}

#Preview {

    func preview(for type: Keyboard.KeyboardType) -> some View {
        let state = Keyboard.State.preview
        state.keyboardContext.keyboardType = type
        state.keyboardContext.settings.inputToolbarType = .numbers
        return KeyboardView(
            layout: KeyboardLayout.BaseLayoutService(
                alphabeticInputSet: .qwerty,
                numericInputSet: .numeric,
                symbolicInputSet: .symbolic
            ).keyboardLayout(for: state.keyboardContext),
            state: state,
            services: .preview
        )
    }

    return VStack {
        preview(for: .alphabetic)
        preview(for: .numeric)
        preview(for: .symbolic)
    }.background(Color.keyboardBackground)
}
