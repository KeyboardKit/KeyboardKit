//
//  iPhoneKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This class provides a keyboard layout that corresponds to a
 standard QWERTY layout for an iPhone device.

 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 */
open class iPhoneKeyboardLayoutProvider: BaseKeyboardLayoutProvider {


    // MARK: - Overrides

    open override func actions(
        for inputs: InputSet.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Rows {
        let actions = super.actions(for: inputs, context: context)
        guard isExpectedActionSet(actions) else { return actions }
        var result = KeyboardAction.Rows()
        result.append(topLeadingActions(for: actions, context: context) + actions[0] + topTrailingActions(for: actions, context: context))
        result.append(middleLeadingActions(for: actions, context: context) + actions[1] + middleTrailingActions(for: actions, context: context))
        result.append(lowerLeadingActions(for: actions, context: context) + actions[2] + lowerTrailingActions(for: actions, context: context))
        result.append(bottomActions(for: context))
        return result
    }

    open override func itemSizeWidth(
        for action: KeyboardAction,
        row: Int,
        index: Int,
        context: KeyboardContext
    ) -> KeyboardLayout.ItemWidth {
        switch action {
        case context.keyboardDictationReplacement: return bottomSystemButtonWidth(for: context)
        case .character: return isLastNumericInputRow(row, for: context) ? lastSymbolicInputWidth(for: context) : .input
        case .backspace: return lowerSystemButtonWidth(for: context)
        case .keyboardType: return bottomSystemButtonWidth(for: context)
        case .nextKeyboard: return bottomSystemButtonWidth(for: context)
        case .primary: return .percentage(isPortrait(context) ? 0.25 : 0.195)
        case .shift: return lowerSystemButtonWidth(for: context)
        default: return .available
        }
    }


    // MARK: - iPhone Specific

    /// Leading actions to add to the top input row.
    open func topLeadingActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard shouldAddUpperMarginActions(for: actions, context: context) else { return [] }
        return [actions[0].leadingCharacterMarginAction]
    }

    /// Trailing actions to add to the top input row.
    open func topTrailingActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard shouldAddUpperMarginActions(for: actions, context: context) else { return [] }
        return [actions[0].trailingCharacterMarginAction]
    }

    /// Leading actions to add to the middle input row.
    open func middleLeadingActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard shouldAddMiddleMarginActions(for: actions, context: context) else { return [] }
        return [actions[1].leadingCharacterMarginAction]
    }

    /// Trailing actions to add to the middle input row.
    open func middleTrailingActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard shouldAddMiddleMarginActions(for: actions, context: context) else { return [] }
        return [actions[1].trailingCharacterMarginAction]
    }

    /// Leading actions to add to the lower input row.
    open func lowerLeadingActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard isExpectedActionSet(actions) else { return [] }
        let margin = actions[2].leadingCharacterMarginAction
        guard let switcher = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [switcher, margin]
    }

    /// Trailing actions to add to the lower input row.
    open func lowerTrailingActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard isExpectedActionSet(actions) else { return [] }
        let margin = actions[2].trailingCharacterMarginAction
        return [margin, .backspace]
    }

    /// The width of system buttons on the lower input row.
    open func lowerSystemButtonWidth(
        for context: KeyboardContext
    ) -> KeyboardLayout.ItemWidth {
        if context.isAlphabetic(.ukrainian) { return .input }
        return .percentage(0.13)
    }

    /// The actions to add to the bottom system row.
    open func bottomActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        var result = KeyboardAction.Row()
        let needsInputSwitch = context.needsInputModeSwitchKey
        let needsDictation = context.needsInputModeSwitchKey
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        if needsInputSwitch { result.append(.nextKeyboard) }
        if !needsInputSwitch { result.append(.keyboardType(.emojis)) }
        let dictationReplacement = context.keyboardDictationReplacement
        if isPortrait(context), needsDictation, let action = dictationReplacement { result.append(action) }
        result.append(.space)
        #if os(iOS) || os(tvOS)
        if context.textDocumentProxy.keyboardType == .emailAddress {
            result.append(.character("@"))
            result.append(.character("."))
        }
        if context.textDocumentProxy.returnKeyType == .go {
            result.append(.character("."))
        }
        #endif
        result.append(keyboardReturnAction(for: context))
        if !isPortrait(context), needsDictation, let action = dictationReplacement { result.append(action) }
        return result
    }

    /// The width of system buttons on the bottom system row.
    open func bottomSystemButtonWidth(
        for context: KeyboardContext
    ) -> KeyboardLayout.ItemWidth {
        .percentage(isPortrait(context) ? 0.123 : 0.095)
    }

    /// Whether or not to add margins to the middle row.
    open func shouldAddMiddleMarginActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> Bool {
        guard isExpectedActionSet(actions) else { return false }
        return actions[0].count > actions[1].count
    }

    /// Whether or not to add margins to the upper row.
    open func shouldAddUpperMarginActions(
        for actions: KeyboardAction.Rows,
        context: KeyboardContext
    ) -> Bool {
        false
    }
}

private extension iPhoneKeyboardLayoutProvider {

    func isExpectedActionSet(_ actions: KeyboardAction.Rows) -> Bool {
        actions.count == 3
    }

    func isPortrait(_ context: KeyboardContext) -> Bool {
        context.interfaceOrientation.isPortrait
    }

    /**
     The width of the last numeric/symbolic row input button.
     */
    func lastSymbolicInputWidth(
        for context: KeyboardContext
    ) -> KeyboardLayout.ItemWidth {
        .percentage(0.14)
    }

    /**
     Whether or not a certain row is the last input row in a
     numeric or symbolic keyboard.
     */
    func isLastNumericInputRow(_ row: Int, for context: KeyboardContext) -> Bool {
        let isNumeric = context.keyboardType == .numeric
        let isSymbolic = context.keyboardType == .symbolic
        guard isNumeric || isSymbolic else { return false }
        return row == 2 // Index 2 is the "wide keys" row
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
