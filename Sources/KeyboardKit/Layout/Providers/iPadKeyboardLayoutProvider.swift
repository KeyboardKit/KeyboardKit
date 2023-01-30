//
//  iPadKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This class provides a keyboard layout that correspond to an
 iPad with a home button.

 The provider will use input count patterns when the certain
 pattern should determine the layout regardless of locale. A
 locale-based layout is not as general, but is more precise.

 You can inherit this class and override any open properties
 and functions to customize the standard behavior.

 Note that this provider is used on iPad Air and Pro devices
 as well, although they should use different layouts.
 */
open class iPadKeyboardLayoutProvider: SystemKeyboardLayoutProvider {


    // MARK: - Overrides

    /**
     Get keyboard actions for the `inputs` and `context`.

     Note that `inputs` is an input set and does not contain
     the bottommost space key row, which we therefore append.
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
     Get a layout item width for the provided parameters.
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
        case .backspace: return .input
        // case .primary: if hasAlphabeticInputCount([12, 12, 10]) { return .available }   // e.g. Belarusian
        default: break
        }

        if action.isSystemAction { return systemButtonWidth(for: context) }

        return super.itemSizeWidth(for: action, row: row, index: index, context: context)
    }

    /**
     The standard system button width.
     */
    open func systemButtonWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        return .input
    }

    /**
     The return action to use for the provided `context`.
     */
    open override func keyboardReturnAction(for context: KeyboardContext) -> KeyboardAction {
        let base = super.keyboardReturnAction(for: context)
        return base == .primary(.return) ? .primary(.newLine) : base
    }


    // MARK: - iPad Specific

    /**
     Get the actions that should be bottommost on a keyboard
     that uses the standard iPad keyboard layout.

     This is currently pretty messy and should be cleaned up.
     */
    open func bottomActions(for context: KeyboardContext) -> KeyboardActions {
        var result = KeyboardActions()
        let needsDictation = context.needsInputModeSwitchKey
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        result.append(.nextKeyboard)
        if needsDictation, let action = context.keyboardDictationReplacement { result.append(action) }
        result.append(.space)
        if context.isAlphabetic(.persian) { result.append(.character(.zeroWidthSpace)) }
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        result.append(.dismissKeyboard)
        return result
    }

    /**
     Additional leading actions to apply to the lower row.
     */
    open func lowerLeadingActions(for context: KeyboardContext) -> KeyboardActions {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        if context.isAlphabetic(.hebrew) { return [.none] }
        if context.isAlphabetic(.kurdish_sorani_arabic) { return [] }
        if context.isAlphabetic(.kurdish_sorani_pc) { return [] }
        if context.isAlphabetic(.persian) { return [] }
        return [action]
    }

    /**
     Additional trailing actions to apply to the lower row.
     */
    open func lowerTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        if context.isAlphabetic(.hebrew) { return [.primary(.newLine)] }
        if context.isAlphabetic(.kurdish_sorani_arabic) { return [keyboardReturnAction(for: context)] }
        if context.isAlphabetic(.kurdish_sorani_pc) { return [keyboardReturnAction(for: context)] }
        if context.isAlphabetic(.persian) { return [] }
        // if hasAlphabeticInputCount([12, 12, 10]) { return [.primary(.newLine)] }  // e.g. Belarusian
        return [action]
    }

    /**
     Additional leading actions to apply to the middle row.
     */
    open func middleLeadingActions(for context: KeyboardContext) -> KeyboardActions {
        if context.isAlphabetic(.hebrew) { return [] }
        // if hasAlphabeticInputCount([12, 12, 10]) { return [] }  // e.g. Belarusian
        return [.none]
    }

    /**
     Additional trailing actions to apply to the middle row.
     */
    open func middleTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        if context.isAlphabetic(.hebrew) { return [] }
        if context.isAlphabetic(.kurdish_sorani_arabic) { return [] }
        if context.isAlphabetic(.kurdish_sorani_pc) { return [] }
        // if hasAlphabeticInputCount([12, 12, 10]) { return [] }  // e.g. Belarusian
        return [keyboardReturnAction(for: context)]
    }

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


// MARK: - KeyboardContext Extension

private extension KeyboardContext {

    /// This function makes the context checks above shorter.
    func `is`(_ locale: KeyboardLocale) -> Bool {
        hasKeyboardLocale(locale)
    }

    /// This function makes the context checks above shorter.
    func isAlphabetic(_ locale: KeyboardLocale) -> Bool {
        hasKeyboardLocale(locale) && keyboardType.isAlphabetic
    }
}
