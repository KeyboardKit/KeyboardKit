//
//  iPadKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This class provides a keyboard layout that corresponds to a
 standard QWERTY layout for an iPad with a home button.

 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 > Note: This class is currently used to provide layouts for
 all iPad types, although iPad Air and Pro have more buttons.
 This should be addressed in a future version.
 */
open class iPadKeyboardLayoutProvider: BaseKeyboardLayoutProvider {


    // MARK: - Overrides

    open override func actions(
        for inputs: InputSet.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Rows {
        let actions = super.actions(for: inputs, context: context)
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
    
    /// The standard system button width for a context.
    open func systemButtonWidth(
        for context: KeyboardContext
    ) -> KeyboardLayout.ItemWidth {
        return .input
    }

    /// Leading actions to add to the top input row.
    open func topLeadingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        return []
    }

    /// Trailing actions to add to the top input row.
    open func topTrailingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        return [.backspace]
    }

    /// Leading actions to add to the middle input row.
    open func middleLeadingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        return [.none]
    }

    /// Trailing actions to add to the middle input row.
    open func middleTrailingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        return [keyboardReturnAction(for: context)]
    }

    /// Leading actions to add to the lower input row.
    open func lowerLeadingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [action]
    }

    /// Trailing actions to add to the lower input row.
    open func lowerTrailingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [action]
    }

    /// The actions to add to the bottom system row.
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
}


// MARK: - Private utils

private extension iPadKeyboardLayoutProvider {

    func isLowerTrailingSwitcher(_ action: KeyboardAction, row: Int, index: Int) -> Bool {
        switch action {
        case .shift, .keyboardType: return row == 2 && index > 0
        default: return false
        }
    }
}
