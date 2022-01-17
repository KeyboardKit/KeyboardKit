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
        context: KeyboardContext) -> KeyboardActionRows {
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
        context: KeyboardContext) -> KeyboardLayoutItemWidth {
        if action.isPrimaryAction { return bottomPrimaryButtonWidth(for: context) }
        switch action {
        case dictationReplacement: return bottomSystemButtonWidth(for: context)
        case .character:
            if isGreekAlphabetic(context) { return .percentage(0.1) }
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
    open func bottomActions(for context: KeyboardContext) -> KeyboardActions {
        var result = KeyboardActions()
        let portrait = context.screenOrientation.isPortrait
        let needsInputSwitch = context.needsInputModeSwitchKey
        let needsDictation = context.needsInputModeSwitchKey
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        if needsInputSwitch { result.append(.nextKeyboard) }
        if !needsInputSwitch { result.append(.keyboardType(.emojis)) }
        if portrait, needsDictation, let action = dictationReplacement { result.append(action) }
        result.append(.space)
        if isPersianAlphabetic(context) { result.append(.character(.zeroWidthSpace)) }
        result.append(keyboardReturnAction(for: context))
        if !portrait, needsDictation, let action = dictationReplacement { result.append(action) }
        return result
    }    
    /**
     Get leading actions to add to the lower inputs row.
     */
    open func lowerLeadingActions(for actions: KeyboardActionRows, context: KeyboardContext) -> KeyboardActions {
        guard isExpectedPhoneInputActions(actions) else { return [] }
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        if isCzechAlphabetic(context) { return [action] }
        if isArabicAlphabetic(context) { return [] }
        if isBelarusianAlphabetic(context) { return [action] }
        if isPersianAlphabetic(context) { return [] }
        if isRussianAlphabetic(context) { return [action] }
        if isUkrainianAlphabetic(context) { return [action] }
        return [action, leadingMarginAction(for: actions[2])]
    }
    
    /**
     Get trailing actions to add to the lower inputs row.
     */
    open func lowerTrailingActions(for actions: KeyboardActionRows, context: KeyboardContext) -> KeyboardActions {
        guard isExpectedPhoneInputActions(actions) else { return [] }
        if isCzechAlphabetic(context) { return [.backspace] }
        if isBelarusianAlphabetic(context) { return [.backspace] }
        if isPersianAlphabetic(context) { return [.backspace] }
        if isRussianAlphabetic(context) { return [.backspace] }
        if isUkrainianAlphabetic(context) { return [.backspace] }
        return [trailingMarginAction(for: actions[2]), .backspace]
    }
    
    /**
     Get leading actions to add to the middle inputs row.
     */
    open func middleLeadingActions(for actions: KeyboardActionRows, context: KeyboardContext) -> KeyboardActions {
        guard shouldAddMiddleMarginActions(for: actions, context: context) else { return [] }
        return [leadingMarginAction(for: actions[1])]
    }
    
    /**
     Get trailing actions to add to the middle inputs row.
     */
    open func middleTrailingActions(for actions: KeyboardActionRows, context: KeyboardContext) -> KeyboardActions {
        guard shouldAddMiddleMarginActions(for: actions, context: context) else { return [] }
        return [trailingMarginAction(for: actions[1])]
    }
    
    /**
     Get leading actions to add to the upper inputs row.
     */
    open func upperLeadingActions(for actions: KeyboardActionRows, context: KeyboardContext) -> KeyboardActions {
        guard shouldAddUpperMarginActions(for: actions, context: context) else { return [] }
        return [leadingMarginAction(for: actions[1])]
    }
    
    /**
     Get trailing actions to add to the upper inputs row.
     */
    open func upperTrailingActions(for actions: KeyboardActionRows, context: KeyboardContext) -> KeyboardActions {
        guard shouldAddUpperMarginActions(for: actions, context: context) else { return [] }
        return [trailingMarginAction(for: actions[1])]
    }
    
    
    // MARK: - Deprecated
    
    @available(*, deprecated, message: "Use for:context instead")
    open func lowerLeadingActions(for context: KeyboardContext) -> KeyboardActions {
        lowerLeadingActions(for: [], context: context)
    }
    
    @available(*, deprecated, message: "Use for:context instead")
    open func lowerTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        lowerTrailingActions(for: [], context: context)
    }
}

private extension iPhoneKeyboardLayoutProvider {
    
    func isExpectedPhoneInputActions(_ actions: KeyboardActionRows) -> Bool {
        actions.count == 3
    }
    
    func isPortrait(_ context: KeyboardContext) -> Bool {
        context.screenOrientation.isPortrait
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
        .percentage(isPortrait(context) ? 0.125 : 0.097)
    }
    
    /**
     The system buttons that are shown to the left and right
     of the third row's input buttons.
     */
    func lowerSystemButtonWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        if hasTwelveElevenNineAlphabeticInput { return .percentage(0.11) }
        if isBelarusianAlphabetic(context) { return .available }
        if isCzechAlphabetic(context) { return .input }
        if isPersianAlphabetic(context) { return .input }
        if isRussianAlphabetic(context) { return .input }
        if isUkrainianAlphabetic(context) { return .input }
        return .percentage(0.12)
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
     Whether or not to add margin actions to the lower row.
     */
    func shouldAddLowerMarginActions(for actions: KeyboardActionRows, context: KeyboardContext) -> Bool {
        guard isExpectedPhoneInputActions(actions) else { return false }
        if isGreekAlphabetic(context) { return true }
        return false
    }
    
    /**
     Whether or not to add margin actions to the middle row.
     */
    func shouldAddMiddleMarginActions(for actions: KeyboardActionRows, context: KeyboardContext) -> Bool {
        guard isExpectedPhoneInputActions(actions) else { return false }
        if isGreekAlphabetic(context) { return true }
        return actions[0].count > actions[1].count
    }
    
    /**
     Whether or not to add margin actions to the upper row.
     */
    func shouldAddUpperMarginActions(for actions: KeyboardActionRows, context: KeyboardContext) -> Bool {
        guard isExpectedPhoneInputActions(actions) else { return false }
        if isGreekAlphabetic(context) { return true }
        return false
    }
}
