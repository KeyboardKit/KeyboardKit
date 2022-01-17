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
        context: KeyboardContext) -> KeyboardActionRows {
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
        context: KeyboardContext) -> KeyboardLayoutItemWidth {
        let elevenEleven = hasElevenElevenAlphabeticInput
        if action == .backspace && isArabic(context) { return .input }
        if isThirdRowLeadingSwitcher(action, row: row, index: index) && isArabic(context) { return .input }
        if isSecondRowSpacer(action, row: row, index: index) { return .inputPercentage(elevenEleven ? 0.3 : 0.4) }
        if isThirdRowLeadingSwitcher(action, row: row, index: index) { return elevenEleven ? .inputPercentage(1.1) : .input }
        if isThirdRowTrailingSwitcher(action, row: row, index: index) { return .available }
        if isBottomRowLeadingSwitcher(action, row: row, index: index) { return .input }
        if isBottomRowTrailingSwitcher(action, row: row, index: index) { return .inputPercentage(1.45) }
        switch action {
        case dictationReplacement: return .input
        case .backspace:
            if isGreekAlphabetic(context) { return .percentage(0.125) }
            return .percentage(elevenEleven ? 0.125 : 0.095)
        case .dismissKeyboard: return .inputPercentage(1.45)
        case .keyboardType: return row == 2 ? .available : .input
        case .nextKeyboard: return .input
        case .newLine:
            if isBelarusianAlphabetic(context) { return .available }
        default: break
        }
        return super.itemSizeWidth(for: action, row: row, index: index, context: context)
    }
    
    /**
     The return action to use for the provided `context`.
     */
    open override func keyboardReturnAction(for context: KeyboardContext) -> KeyboardAction {
        let base = super.keyboardReturnAction(for: context)
        return base == .return ? .newLine : base
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
        if needsDictation, let action = dictationReplacement { result.append(action) }
        result.append(.space)
        if isPersianAlphabetic(context) { result.append(.character(.zeroWidthSpace)) }
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        result.append(.dismissKeyboard)
        return result
    }
    
    /**
     Additional leading actions to apply to the lower row.
     */
    open func lowerLeadingActions(for context: KeyboardContext) -> KeyboardActions {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        if isArabicAlphabetic(context) { return [] }
        if isPersianAlphabetic(context) { return [] }
        return [action]
    }
    
    /**
     Additional trailing actions to apply to the lower row.
     */
    open func lowerTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        if isArabicAlphabetic(context) { return [keyboardReturnAction(for: context)] }
        if isPersianAlphabetic(context) { return [] }
        if isBelarusianAlphabetic(context) { return [.newLine] }
        return [action]
    }
    
    /**
     Additional leading actions to apply to the middle row.
     */
    open func middleLeadingActions(for context: KeyboardContext) -> KeyboardActions {
        if isBelarusianAlphabetic(context) { return [] }
        return [.none]
    }
    
    /**
     Additional trailing actions to apply to the middle row.
     */
    open func middleTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        if isArabic(context) { return [] }
        if isBelarusianAlphabetic(context) { return [] }
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

private extension iPadKeyboardLayoutProvider {
    
    func isBottomRowLeadingSwitcher(_ action: KeyboardAction, row: Int, index: Int) -> Bool {
        switch action {
        case .shift, .keyboardType: return row == 3 && index == 0
        default: return false
        }
    }
    
    func isBottomRowTrailingSwitcher(_ action: KeyboardAction, row: Int, index: Int) -> Bool {
        switch action {
        case .shift, .keyboardType: return row == 3 && index > 0
        default: return false
        }
    }
    
    func isPortrait(_ context: KeyboardContext) -> Bool {
        context.screenOrientation.isPortrait
    }
    
    func isSecondRowSpacer(_ action: KeyboardAction, row: Int, index: Int) -> Bool {
        switch action {
        case .none: return row == 1 && index == 0
        default: return false
        }
    }
    
    func isThirdRowLeadingSwitcher(_ action: KeyboardAction, row: Int, index: Int) -> Bool {
        switch action {
        case .shift, .keyboardType: return row == 2 && index == 0
        default: return false
        }
    }
    
    func isThirdRowTrailingSwitcher(_ action: KeyboardAction, row: Int, index: Int) -> Bool {
        switch action {
        case .shift, .keyboardType: return row == 2 && index > 0
        default: return false
        }
    }
}
