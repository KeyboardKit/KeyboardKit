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
 
 You can inherit this class and override any implementations
 to customize the standard layout.
 
 `TODO` Unit test this class.
 
 `TODO` This class is currently used for iPad Air/Pro. These
 device types should use a different layout.
 
 `TODO` The bottom-right button should not be `.newLine` but
 rather the `primary` action for the current context.
 */
open class iPadKeyboardLayoutProvider: BaseKeyboardLayoutProvider {
    
    
    // MARK: - Overrides
    
    /**
     Get keyboard actions for the provided context and inputs.
     */
    open override func actions(for context: KeyboardContext, inputs: KeyboardInputRows) -> KeyboardActionRows {
        var actions = super.actions(for: context, inputs: inputs)
        assert(actions.count > 2, "An iPad system layout requires at least 3 input rows.")
        let last = actions.suffix(3)
        actions.removeLast(3)
        actions.append(last[0] + [.backspace])
        actions.append([.none] + last[1] + [.newLine])
        actions.append(lowerLeadingActions(for: context) + last[2] + lowerTrailingActions(for: context))
        actions.append(bottomActions(for: context))
        return actions
    }
    
    open override func itemSizeWidth(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutWidth {
        //if isSecondRowSpacer(action, row: row) { return .useReferencePercentage(0.4) }
        //switch action {
        //case dictationReplacement: return .useReference
        //case .backspace: return .percentage(0.1)
        //case .dismissKeyboard: return .useReferencePercentage(1.8)
        //case .keyboardType: return row == 2 ? .available : .useReference
        //case .nextKeyboard: return .useReference
        //default: return super.itemSizeWidth(for: context, action: action, row: row, index: index)
        //}
        return super.itemSizeWidth(for: context, action: action, row: row, index: index)
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
        guard let action = keyboardSwitcherActionForBottomInputRow(for: context) else { return [] }
        return [action]
    }
    
    open func lowerTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        guard let action = keyboardSwitcherActionForBottomInputRow(for: context) else { return [] }
        return [action]
    }
}

private extension iPadKeyboardLayoutProvider {
    
    func isSecondRowSpacer(_ action: KeyboardAction, row: Int) -> Bool {
        action == .none && row == 1
    }
}
