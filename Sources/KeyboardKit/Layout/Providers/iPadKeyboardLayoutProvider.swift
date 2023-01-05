//
//  iPadKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
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

 `TODO` This provider is currently used for iPad Air and Pro
 devices as well, although they should use different layouts.
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
        if isMiddleLeadingSpacer(action, row: row, index: index) { return middleLeadingSpacerWidth(for: context) }
        if isLowerLeadingSwitcher(action, row: row, index: index) { return lowerLeadingSwitcherWidth(for: context) }
        if isLowerTrailingSwitcher(action, row: row, index: index) { return lowerTrailingSwitcherWidth(for: context) }
        if isBottomLeadingSwitcher(action, row: row, index: index) { return bottomLeadingSwitcherWidth(for: context) }
        if isBottomTrailingSwitcher(action, row: row, index: index) { return bottomTrailingSwitcherWidth(for: context) }

        switch action {
        case context.keyboardDictationReplacement: return .input
        case .backspace: return backspaceWidth(for: context)
        case .dismissKeyboard: return .inputPercentage(1.45)
        case .keyboardType: return row == 2 ? .available : .input
        case .nextKeyboard: return .input
        case .newLine: if hasAlphabeticInputCount([12, 12, 10]) { return .available }   // e.g. Belarusian
        default: break
        }

        return super.itemSizeWidth(for: action, row: row, index: index, context: context)
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
        if context.isAlphabetic(.arabic) { return [] }
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
        if context.isAlphabetic(.arabic) { return [keyboardReturnAction(for: context)] }
        if context.isAlphabetic(.hebrew) { return [.primary(.newLine)] }
        if context.isAlphabetic(.kurdish_sorani_arabic) { return [keyboardReturnAction(for: context)] }
        if context.isAlphabetic(.kurdish_sorani_pc) { return [keyboardReturnAction(for: context)] }
        if context.isAlphabetic(.persian) { return [] }
        if hasAlphabeticInputCount([12, 12, 10]) { return [.primary(.newLine)] }  // e.g. Belarusian
        return [action]
    }

    /**
     Additional leading actions to apply to the middle row.
     */
    open func middleLeadingActions(for context: KeyboardContext) -> KeyboardActions {
        if context.isAlphabetic(.hebrew) { return [] }
        if hasAlphabeticInputCount([12, 12, 10]) { return [] }  // e.g. Belarusian
        return [.none]
    }

    /**
     Additional trailing actions to apply to the middle row.
     */
    open func middleTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        if context.isAlphabetic(.arabic) { return [] }
        if context.isAlphabetic(.hebrew) { return [] }
        if context.isAlphabetic(.kurdish_sorani_arabic) { return [] }
        if context.isAlphabetic(.kurdish_sorani_pc) { return [] }
        if hasAlphabeticInputCount([12, 12, 10]) { return [] }  // e.g. Belarusian
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

// MARK: - Width functions

private extension iPadKeyboardLayoutProvider {

    func backspaceWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        if context.is(.arabic) { return .input }
        if context.is(.kurdish_sorani_arabic) { return .input }
        if context.is(.kurdish_sorani_pc) { return .input }
        if context.is(.persian) { return .input }
        if hasAlphabeticInputCount([12, 12, 10]) { return .input }  // e.g. Belarusian
        return .percentage(0.125)
    }

    func middleLeadingSpacerWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        .inputPercentage(0.3)
    }

    func lowerLeadingSwitcherWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        if hasAlphabeticInputCount([11, 11, 9]) { return .inputPercentage(1.1) }    // e.g. Swedish
        return .input
    }

    func lowerTrailingSwitcherWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        .available
    }

    func bottomLeadingSwitcherWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        lowerLeadingSwitcherWidth(for: context)
    }

    func bottomTrailingSwitcherWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        lowerLeadingSwitcherWidth(for: context)
    }
}



// MARK: - Private utils

private extension iPadKeyboardLayoutProvider {

    func isBottomLeadingSwitcher(_ action: KeyboardAction, row: Int, index: Int) -> Bool {
        switch action {
        case .shift, .keyboardType: return row == 3 && index == 0
        default: return false
        }
    }

    func isBottomTrailingSwitcher(_ action: KeyboardAction, row: Int, index: Int) -> Bool {
        switch action {
        case .shift, .keyboardType: return row == 3 && index > 0
        default: return false
        }
    }

    func isMiddleLeadingSpacer(_ action: KeyboardAction, row: Int, index: Int) -> Bool {
        switch action {
        case .none: return row == 1 && index == 0
        default: return false
        }
    }

    func isLowerLeadingSwitcher(_ action: KeyboardAction, row: Int, index: Int) -> Bool {
        switch action {
        case .shift, .keyboardType: return row == 2 && index == 0
        default: return false
        }
    }

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
