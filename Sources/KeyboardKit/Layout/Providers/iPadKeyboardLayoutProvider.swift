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
 standard English layout for an iPad with a home button.

 Note that this provider is currently used on all iPad types,
 including iPad Air and iPad Pro, although they use a layout
 that has more system buttons.

 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 */
open class iPadKeyboardLayoutProvider: SystemKeyboardLayoutProvider {


    // MARK: - Overrides

    /**
     Get the keyboard actions for the `inputs` and `context`.

     Note that `inputs` is an input set that doesn't contain
     the bottommost row. We therefore append it here.
     */
    open override func actions(
        for inputs: InputSetRows,
        context: KeyboardContext
    ) -> KeyboardActionRows {
        let actions = super.actions(for: inputs, context: context)
        guard actions.count == 3 else { return actions }
        var result = KeyboardActionRows()
        result.append(topLeadingActions(for: context) + actions[0] + topTrailingActions(for: context))
        result.append(middleLeadingActions(for: context) + actions[1] + middleTrailingActions(for: context))
        result.append(lowerLeadingActions(for: context) + actions[2] + lowerTrailingActions(for: context))
        result.append(bottomActions(for: context))
        return result
    }

    /**
     Get the keyboard layout item width of a certain `action`
     for the provided `context`, `row` and row `index`.
     */
    open override func itemSizeWidth(
        for action: KeyboardAction,
        row: Int,
        index: Int,
        context: KeyboardContext
    ) -> KeyboardLayoutItemWidth {
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

    /**
     The return action to use for the provided `context`.
     */
    open override func keyboardReturnAction(
        for context: KeyboardContext
    ) -> KeyboardAction {
        let base = super.keyboardReturnAction(for: context)
        return base == .primary(.return) ? .primary(.newLine) : base
    }

    /**
     The standard system button width.
     */
    open func systemButtonWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        return .input
    }


    // MARK: - iPad Specific

    /**
     Additional leading actions to apply to the top row.
     */
    open func topLeadingActions(for context: KeyboardContext) -> KeyboardActions {
        return []
    }

    /**
     Additional trailing actions to apply to the top row.
     */
    open func topTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        return [.backspace]
    }

    /**
     Additional leading actions to apply to the middle row.
     */
    open func middleLeadingActions(for context: KeyboardContext) -> KeyboardActions {
        return [.none]
    }

    /**
     Additional trailing actions to apply to the middle row.
     */
    open func middleTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        return [keyboardReturnAction(for: context)]
    }

    /**
     Additional leading actions to apply to the lower row.
     */
    open func lowerLeadingActions(for context: KeyboardContext) -> KeyboardActions {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [action]
    }

    /**
     Additional trailing actions to apply to the lower row.
     */
    open func lowerTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [action]
    }

    /**
     The actions to add to the bottommost row.
     */
    open func bottomActions(for context: KeyboardContext) -> KeyboardActions {
        var result = KeyboardActions()
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
