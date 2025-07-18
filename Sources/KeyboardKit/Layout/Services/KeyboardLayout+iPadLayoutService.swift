//
//  KeyboardLayout+iPadLayoutService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension KeyboardLayout {
    
    /// This base class provides a foundation for generating
    /// iPad-specific layouts.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    ///
    /// KeyboardKit Pro unlocks an additional service for an
    /// iPad Pro-specific layout.
    open class iPadLayoutService: KeyboardLayout.BaseLayoutService {

        // MARK: - Overrides

        open override func itemActions(
            for context: KeyboardContext
        ) -> KeyboardAction.Rows {
            let actions = super.itemActions(for: context)
            guard actions.count == 3 else { return actions }
            var result = KeyboardAction.Rows()
            result.append(topLeadingActions(for: context) + actions[0] + topTrailingActions(for: context))
            result.append(middleLeadingActions(for: context) + actions[1] + middleTrailingActions(for: context))
            result.append(lowerLeadingActions(for: context) + actions[2] + lowerTrailingActions(for: context))
            result.append(bottomActions(for: context))
            return result
        }
        
        open override func itemSizeWidth(
            for action: KeyboardAction,
            row: Int,
            index: Int,
            context: KeyboardContext
        ) -> KeyboardLayout.ItemWidth {
            if isLowerTrailingSwitcher(action, row: row, index: index) { return .available }
            switch action {
            case context.keyboardDictationReplacement: return .input
            case .none: return .inputPercentage(0.4)
            case .primary: return .available
            default: break
            }
            if action.isSystemAction { return systemButtonWidth(for: context) }
            return super.itemSizeWidth(for: action, row: row, index: index, context: context)
        }
        
        open override func keyboardReturnAction(
            for context: KeyboardContext
        ) -> KeyboardAction {
            let base = super.keyboardReturnAction(for: context)
            return base == .primary(.return) ? .primary(.newLine) : base
        }
        
        
        // MARK: - iPad Specific
        
        /// The top input row's leading actions.
        open func topLeadingActions(
            for context: KeyboardContext
        ) -> KeyboardAction.Row {
            []
        }
        
        /// The top input row's trailing actions.
        open func topTrailingActions(
            for context: KeyboardContext
        ) -> KeyboardAction.Row {
            [.backspace]
        }
        
        /// The middle input row's leading actions.
        open func middleLeadingActions(
            for context: KeyboardContext
        ) -> KeyboardAction.Row {
            [.none]
        }
        
        /// The middle input row's trailing actions.
        open func middleTrailingActions(
            for context: KeyboardContext
        ) -> KeyboardAction.Row {
            [keyboardReturnAction(for: context)]
        }
        
        /// The lower input row's leading actions.
        open func lowerLeadingActions(
            for context: KeyboardContext
        ) -> KeyboardAction.Row {
            guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
            return [action]
        }
        
        /// The lower input row's trailing actions.
        open func lowerTrailingActions(
            for context: KeyboardContext
        ) -> KeyboardAction.Row {
            guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
            return [action]
        }
        
        /// The bottom row actions.
        open func bottomActions(for context: KeyboardContext) -> KeyboardAction.Row {
            var result = KeyboardAction.Row()
            let needsDictation = context.needsInputModeSwitchKey
            if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
            result.append(.nextKeyboard)
            if needsDictation, let action = context.keyboardDictationReplacement { result.append(action) }
            result.append(.space)
            if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
            result.append(.dismissKeyboard)
            return result
        }
        
        /// The standard system button width for a context.
        open func systemButtonWidth(
            for context: KeyboardContext
        ) -> KeyboardLayout.ItemWidth {
            .input
        }
    }
}


// MARK: - Private functions

extension KeyboardLayout.iPadLayoutService {

    func isBottomTrailingSwitcher(
        _ action: KeyboardAction,
        row: Int,
        index: Int
    ) -> Bool {
        switch action {
        case .shift, .keyboardType: row == 3 && index == 0
        default: false
        }
    }
    
    func isLowerLeadingSwitcher(
        _ action: KeyboardAction,
        row: Int,
        index: Int
    ) -> Bool {
        switch action {
        case .shift, .keyboardType: row == 2 && index == 0
        default: false
        }
    }
    
    func isLowerTrailingSwitcher(
        _ action: KeyboardAction,
        row: Int,
        index: Int
    ) -> Bool {
        switch action {
        case .shift, .keyboardType: row == 2 && index > 0
        default: false
        }
    }
}


#Preview {
    
    func layout() -> KeyboardLayout {
        KeyboardLayout.iPadLayoutService(
            alphabeticInputSet: .qwerty,
            numericInputSet: .numeric,
            symbolicInputSet: .symbolic(currencies: [""])
        )
        .keyboardLayout(for: .preview)
    }
    
    return KeyboardView(
        layout: layout(),
        actionHandler: .preview,
        styleService: .preview,
        keyboardContext: .preview,
        autocompleteContext: .preview,
        calloutContext: .preview,
        buttonContent: { $0.view },
        buttonView: { $0.view },
        collapsedView: { $0.view },
        emojiKeyboard: { $0.view },
        toolbar: { $0.view}
    )
    .background(Color.keyboardBackground)
}
