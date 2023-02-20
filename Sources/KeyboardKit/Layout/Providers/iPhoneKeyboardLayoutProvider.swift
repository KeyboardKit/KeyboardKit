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
 standard English layout for an iPhone device.

 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 */
open class iPhoneKeyboardLayoutProvider: SystemKeyboardLayoutProvider {


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
        guard isExpectedActionSet(actions) else { return actions }
        var result = KeyboardActionRows()
        result.append(topLeadingActions(for: actions, context: context) + actions[0] + topTrailingActions(for: actions, context: context))
        result.append(middleLeadingActions(for: actions, context: context) + actions[1] + middleTrailingActions(for: actions, context: context))
        result.append(lowerLeadingActions(for: actions, context: context) + actions[2] + lowerTrailingActions(for: actions, context: context))
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

    /**
     Additional leading actions to apply to the top row.
     */
    open func topLeadingActions(
        for actions: KeyboardActionRows,
        context: KeyboardContext
    ) -> KeyboardActions {
        guard shouldAddUpperMarginActions(for: actions, context: context) else { return [] }
        return [actions[0].leadingCharacterMarginAction]
    }

    /**
     Additional trailing actions to apply to the top row.
     */
    open func topTrailingActions(
        for actions: KeyboardActionRows,
        context: KeyboardContext
    ) -> KeyboardActions {
        guard shouldAddUpperMarginActions(for: actions, context: context) else { return [] }
        return [actions[0].trailingCharacterMarginAction]
    }

    /**
     Additional leading actions to apply to the middle row.
     */
    open func middleLeadingActions(
        for actions: KeyboardActionRows,
        context: KeyboardContext
    ) -> KeyboardActions {
        guard shouldAddMiddleMarginActions(for: actions, context: context) else { return [] }
        return [actions[1].leadingCharacterMarginAction]
    }

    /**
     Additional trailing actions to apply to the middle row.
     */
    open func middleTrailingActions(
        for actions: KeyboardActionRows,
        context: KeyboardContext
    ) -> KeyboardActions {
        guard shouldAddMiddleMarginActions(for: actions, context: context) else { return [] }
        return [actions[1].trailingCharacterMarginAction]
    }

    /**
     Additional leading actions to apply to the lower row.
     */
    open func lowerLeadingActions(
        for actions: KeyboardActionRows,
        context: KeyboardContext
    ) -> KeyboardActions {
        guard isExpectedActionSet(actions) else { return [] }
        let margin = actions[2].leadingCharacterMarginAction
        guard let switcher = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [switcher, margin]
    }

    /**
     Additional trailing actions to apply to the lower row.
     */
    open func lowerTrailingActions(
        for actions: KeyboardActionRows,
        context: KeyboardContext
    ) -> KeyboardActions {
        guard isExpectedActionSet(actions) else { return [] }
        let margin = actions[2].trailingCharacterMarginAction
        return [margin, .backspace]
    }

    /**
     The system buttons that are shown to the left and right
     of the third row's input buttons on a regular keyboard.
     */
    open func lowerSystemButtonWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        if context.isAlphabetic(.ukrainian) { return .input }
        return .percentage(0.13)
    }

    /**
     The actions to add to the bottommost row.
     */
    open func bottomActions(
        for context: KeyboardContext
    ) -> KeyboardActions {
        var result = KeyboardActions()
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

    /**
     The width of bottom-right system buttons.
     */
    open func bottomSystemButtonWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        .percentage(isPortrait(context) ? 0.123 : 0.095)
    }

    /**
     Whether or not to add margin actions to the middle row.
     */
    open func shouldAddMiddleMarginActions(for actions: KeyboardActionRows, context: KeyboardContext) -> Bool {
        guard isExpectedActionSet(actions) else { return false }
        return actions[0].count > actions[1].count
    }

    /**
     Whether or not to add margin actions to the upper row.
     */
    open func shouldAddUpperMarginActions(for actions: KeyboardActionRows, context: KeyboardContext) -> Bool {
        false
    }
}

private extension iPhoneKeyboardLayoutProvider {

    func isExpectedActionSet(_ actions: KeyboardActionRows) -> Bool {
        actions.count == 3
    }

    func isPortrait(_ context: KeyboardContext) -> Bool {
        context.interfaceOrientation.isPortrait
    }

    /**
     The width of the last numeric/symbolic row input button.
     */
    func lastSymbolicInputWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
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
