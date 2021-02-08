//
//  iPadKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This class provides layouts that correspond to an iPad with
 a home button, adding iPad-specific system buttons around a
 basic set of input actions.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 `IMPORTANT` This layout provider has only been tested for a
 couple of locales. If you create a new input set and inject
 it into this layout, you may find that some buttons get the
 wrong size or that system buttons are not where they should
 be. If so, you must create a new layout provider. You could
 then inherit this class and add some customizations.
 
 `TODO` This class is currently used for iPad Air/Pro. These
 device types should use a different layout.
 */
open class iPadKeyboardLayoutProvider: BaseKeyboardLayoutProvider {
    
    
    // MARK: - Overrides
    
    /**
     Get keyboard actions for the provided context and inputs.
     */
    open override func actions(for context: KeyboardContext, inputs: KeyboardInputRows) -> KeyboardActionRows {
        var actions = super.actions(for: context, inputs: inputs)
        assert(actions.count > 2, "iPad layouts require at least 3 input rows.")
        let last = actions.suffix(3)
        actions.removeLast(3)
        actions.append(last[0] + [.backspace])
        actions.append([.none] + last[1] + [.newLine])
        actions.append(lowerLeadingActions(for: context) + last[2] + lowerTrailingActions(for: context))
        actions.append(bottomActions(for: context))
        return actions
    }
    
    open override func itemSizeWidth(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutItemWidth {
        if isSecondRowSpacer(action, row: row, index: index) { return .inputPercentage(0.4) }
        if isSecondBottomSwitcher(action, row: row, index: index) { return .inputPercentage(2) }
        switch action {
        case dictationReplacement: return .input
        case .backspace: return .percentage(0.1)
        case .dismissKeyboard: return .inputPercentage(1.8)
        case .keyboardType: return row == 2 ? .available : .input
        case .nextKeyboard: return .input
        default: return super.itemSizeWidth(for: context, action: action, row: row, index: index)
        }
    }
    
    
    // MARK: - iPad Specific
    
    /**
     Get the bottom action row that should be below the main
     rows on input buttons.
     */
    open func bottomActions(for context: KeyboardContext) -> KeyboardActionRow {
        var result = KeyboardActions()
        let needsDictation = context.needsInputModeSwitchKey
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        result.append(.nextKeyboard)
        if needsDictation, let action = dictationReplacement { result.append(action) }
        result.append(.space)
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        result.append(.dismissKeyboard)
        return result
    }
    
    open func lowerLeadingActions(for context: KeyboardContext) -> KeyboardActions {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [action]
    }
    
    open func lowerTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [action]
    }
}

private extension iPadKeyboardLayoutProvider {
    
    func isSecondBottomSwitcher(_ action: KeyboardAction, row: Int, index: Int) -> Bool {
        switch action {
        case .keyboardType: return row == 3 && index > 3
        default: return false
        }
    }
    
    func isSecondRowSpacer(_ action: KeyboardAction, row: Int, index: Int) -> Bool {
        switch action {
        case .none: return row == 1 && index == 0
        default: return false
        }
    }
}
