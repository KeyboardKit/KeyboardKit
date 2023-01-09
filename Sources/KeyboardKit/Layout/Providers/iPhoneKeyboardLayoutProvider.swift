//
//  iPhoneKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This class provides a keyboard layout that correspond to an
 iPhone with either a home button or notch.

 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 */
open class iPhoneKeyboardLayoutProvider: SystemKeyboardLayoutProvider {


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
        guard isExpectedPhoneInputActions(actions) else { return actions }
        let upper = actions[0]
        let middle = actions[1]
        let lower = actions[2]
        var result = KeyboardActionRows()
        result.append(upperLeadingActions(for: actions, context: context) + upper + upperTrailingActions(for: actions, context: context))
        result.append(middleLeadingActions(for: actions, context: context) + middle + middleTrailingActions(for: actions, context: context))
        result.append(lowerLeadingActions(for: actions, context: context) + lower + lowerTrailingActions(for: actions, context: context))
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
        if action.isPrimaryAction { return bottomPrimaryButtonWidth(for: context) }
        switch action {
        case context.keyboardDictationReplacement: return bottomSystemButtonWidth(for: context)
        case .character:
            if context.isAlphabetic(.greek) { return .percentage(0.1) }
            return isLastNumericInputRow(row, for: context) ? lastSymbolicInputWidth(for: context) : .input
        case .backspace: return lowerSystemButtonWidth(for: context)
        case .keyboardType: return bottomSystemButtonWidth(for: context)
        case .newLine: return bottomPrimaryButtonWidth(for: context)
        case .nextKeyboard: return bottomSystemButtonWidth(for: context)
        case .return: return bottomPrimaryButtonWidth(for: context)
        case .shift: return lowerSystemButtonWidth(for: context)
        default: return .available
        }
    }


    // MARK: - iPhone Specific

    /**
     Get the actions of the bottommost space key row.
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
        if context.isAlphabetic(.persian) { result.append(.character(.zeroWidthSpace)) }
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
     Get leading actions to add to the lower inputs row.
     */
    open func lowerLeadingActions(
        for actions: KeyboardActionRows,
        context: KeyboardContext
    ) -> KeyboardActions {
        guard isExpectedPhoneInputActions(actions) else { return [] }
        let margin = actions[2].leadingCharacterMarginAction
        if context.isAlphabetic(.hebrew) { return [margin] }
        guard let switcher = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        if context.isAlphabetic(.arabic) { return [] }
        if context.isAlphabetic(.kurdish_sorani_arabic) { return [] }
        if context.isAlphabetic(.kurdish_sorani_pc) { return [] }
        if context.isAlphabetic(.persian) { return [] }
        if context.isAlphabetic(.russian) { return [switcher] }
        if context.isAlphabetic(.ukrainian) { return [switcher] }
        if isAlphabeticWithInputCount(context, [10, 10, 8]) { return [switcher] }   // e.g. Czech
        if isAlphabeticWithInputCount(context, [11, 11, 9]) { return [switcher] }   // e.g. Russian
        if isAlphabeticWithInputCount(context, [12, 12, 9]) { return [switcher] }   // e.g. Belarusian
        return [switcher, margin]
    }

    /**
     Get trailing actions to add to the lower inputs row.
     */
    open func lowerTrailingActions(
        for actions: KeyboardActionRows,
        context: KeyboardContext
    ) -> KeyboardActions {
        guard isExpectedPhoneInputActions(actions) else { return [] }
        let margin = actions[2].trailingCharacterMarginAction
        if context.isAlphabetic(.hebrew) { return [margin] }
        if context.isAlphabetic(.arabic) { return [margin, .backspace] }
        if context.isAlphabetic(.kurdish_sorani_arabic) { return [.backspace] }
        if context.isAlphabetic(.kurdish_sorani_pc) { return [margin, .backspace] }
        if context.isAlphabetic(.persian) { return [.backspace] }
        if context.isAlphabetic(.ukrainian) { return [.backspace] }
        if isAlphabeticWithInputCount(context, [10, 10, 8]) { return [.backspace] } // e.g. Czech
        if isAlphabeticWithInputCount(context, [11, 11, 9]) { return [.backspace] } // e.g. Russian
        if isAlphabeticWithInputCount(context, [12, 12, 9]) { return [.backspace] } // e.g. Belarusian
        return [margin, .backspace]
    }

    /**
     Get leading actions to add to the middle inputs row.
     */
    open func middleLeadingActions(
        for actions: KeyboardActionRows,
        context: KeyboardContext
    ) -> KeyboardActions {
        guard shouldAddMiddleMarginActions(for: actions, context: context) else { return [] }
        return [actions[1].leadingCharacterMarginAction]
    }

    /**
     Get trailing actions to add to the middle inputs row.
     */
    open func middleTrailingActions(
        for actions: KeyboardActionRows,
        context: KeyboardContext
    ) -> KeyboardActions {
        guard shouldAddMiddleMarginActions(for: actions, context: context) else { return [] }
        return [actions[1].trailingCharacterMarginAction]
    }

    /**
     Get leading actions to add to the upper inputs row.
     */
    open func upperLeadingActions(
        for actions: KeyboardActionRows,
        context: KeyboardContext
    ) -> KeyboardActions {
        let margin = actions[0].leadingCharacterMarginAction
        if context.isAlphabetic(.hebrew) { return [margin] }
        guard shouldAddUpperMarginActions(for: actions, context: context) else { return [] }
        return [margin]
    }

    /**
     Get trailing actions to add to the upper inputs row.
     */
    open func upperTrailingActions(
        for actions: KeyboardActionRows,
        context: KeyboardContext
    ) -> KeyboardActions {
        let margin = actions[0].trailingCharacterMarginAction
        if context.isAlphabetic(.hebrew) { return [margin, .backspace] }
        guard shouldAddUpperMarginActions(for: actions, context: context) else { return [] }
        return [margin]
    }
}

private extension iPhoneKeyboardLayoutProvider {

    func isExpectedPhoneInputActions(_ actions: KeyboardActionRows) -> Bool {
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
     The width of the bottom-right primary (return) button.
     */
    func bottomPrimaryButtonWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        .percentage(isPortrait(context) ? 0.25 : 0.195)
    }

    /**
     The width of the bottom-right primary (return) button.
     */
    func bottomSystemButtonWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        .percentage(isPortrait(context) ? 0.123 : 0.095)
    }

    /**
     The system buttons that are shown to the left and right
     of the third row's input buttons.
     */
    func lowerSystemButtonWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        let bottomWidth = bottomSystemButtonWidth(for: context)
        let standard = isPortrait(context) ? bottomWidth : .percentage(0.12)
        if context.is(.kurdish_sorani_arabic) { return .input }
        if context.isAlphabetic(.arabic) { return isPortrait(context) ? bottomWidth : .percentage(0.14) }
        if context.isAlphabetic(.kurdish_sorani_pc) { return isPortrait(context) ? bottomWidth : .percentage(0.14) }
        if context.isAlphabetic(.persian) { return .input }
        if context.isAlphabetic(.ukrainian) { return .input }
        if hasAlphabeticInputCount([12, 11, 9]) { return .percentage(0.11) }        // e.g. Turkish
        if isAlphabeticWithInputCount(context, [11, 11, 9]) { return .input }       // e.g. Russian
        if isAlphabeticWithInputCount(context, [10, 10, 8]) { return .input }       // e.g. Czech
        if isAlphabeticWithInputCount(context, [12, 12, 9]) { return .available }   // e.g. Belarusian
        return standard
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

    /**
     Whether or not to add margin actions to the middle row.
     */
    func shouldAddMiddleMarginActions(for actions: KeyboardActionRows, context: KeyboardContext) -> Bool {
        guard isExpectedPhoneInputActions(actions) else { return false }
        if context.isAlphabetic(.greek) { return true }
        return actions[0].count > actions[1].count
    }

    /**
     Whether or not to add margin actions to the upper row.
     */
    func shouldAddUpperMarginActions(for actions: KeyboardActionRows, context: KeyboardContext) -> Bool {
        guard isExpectedPhoneInputActions(actions) else { return false }
        if context.isAlphabetic(.greek) { return true }
        return false
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
