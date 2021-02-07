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
 
 You can inherit this class and override any implementations
 to customize the standard layout.
 
 `IMPORTANT` This layout provider has only been tested for a
 couple of locales. If you create a new input set and inject
 it into this layout, you may find that some buttons get the
 wrong size or that system buttons are not where they should
 be. If so, you must create a new layout provider. You could
 then inherit this class and add some customizations.
 */
open class iPhoneKeyboardLayoutProvider: BaseKeyboardLayoutProvider {
    
    
    // MARK: - Overrides
    
    /**
     Get keyboard actions for the provided context and inputs.
     */
    open override func actions(for context: KeyboardContext, inputs: KeyboardInputRows) -> KeyboardActionRows {
        var actions = super.actions(for: context, inputs: inputs)
        assert(actions.count > 0, "iPhone layouts require at least 1 input row.")
        let last = actions.last ?? []
        actions.removeLast()
        actions.append(lowerLeadingActions(for: context) + last + lowerTrailingActions(for: context))
        actions.append(bottomActions(for: context))
        return actions
    }
    
    open override func itemSizeWidth(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutItemWidth {
        switch action {
        case dictationReplacement: return shortButtonWidth
        case .character: return isLastSymbolicInputRow(row, for: context) ? lastSymbolicInputWidth : .reference
        case .backspace: return mediumButtonWidth
        case .keyboardType: return shortButtonWidth
        case .nextKeyboard: return shortButtonWidth
        case .newLine: return longButtonWidth
        case .shift: return mediumButtonWidth
        default: return .available
        }
    }
    
    
    // MARK: - iPad Specific
    
    /**
     Get the bottom action row that should be below the main
     rows on input buttons.
     */
    open func bottomActions(for context: KeyboardContext) -> KeyboardActionRow {
        var result = KeyboardActions()
        let isPortrait = context.deviceOrientation.isPortrait
        let needsInputSwitcher = context.needsInputModeSwitchKey
        let needsDictation = context.needsInputModeSwitchKey
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        if needsInputSwitcher { result.append(.nextKeyboard) }
        if !needsInputSwitcher { result.append(.keyboardType(.emojis)) }
        if isPortrait, needsDictation, let action = dictationReplacement { result.append(action) }
        result.append(.space)
        result.append(.newLine) // TODO: Should be "primary"
        if !isPortrait, needsDictation, let action = dictationReplacement { result.append(action) }
        return result
    }
    
    open func lowerLeadingActions(for context: KeyboardContext) -> KeyboardActions {
        guard let action = keyboardSwitcherActionForBottomInputRow(for: context) else { return [] }
        return [action, .none]
    }
    
    open func lowerTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        [.none, .backspace]
    }
}

private extension iPhoneKeyboardLayoutProvider {
    
    var lastSymbolicInputWidth: KeyboardLayoutItemWidth { .percentage(0.14) }
    
    var longButtonWidth: KeyboardLayoutItemWidth { .percentage(0.24) }
    
    var mediumButtonWidth: KeyboardLayoutItemWidth { shortButtonWidth }
    
    var shortButtonWidth: KeyboardLayoutItemWidth { .percentage(0.11) }
    
    func isLastSymbolicInputRow(_ row: Int, for context: KeyboardContext) -> Bool {
        let isNumeric = context.keyboardType == .numeric
        let isSymbolic = context.keyboardType == .symbolic
        guard isNumeric || isSymbolic else { return false }
        return row == 2 // Index 2 is the "wide keys" row
    }
}
