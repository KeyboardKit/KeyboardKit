//
//  iPadKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-02.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This layout provider provides a keyboard layout for an iPad.

 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 KeyboardKit Pro has an `iPadProKeyboardLayoutProvider` that
 can create layouts for iPad Air and iPad Pro devices.
 */
open class iPadKeyboardLayoutProvider: BaseKeyboardLayoutProvider {


    // MARK: - Overrides
    
    open override func actions(
        for inputs: InputSet.Rows,
        context: KeyboardContext
    ) -> KeyboardAction.Rows {
        let actions = super.actions(for: inputs, context: context)
        guard actions.count == 3 else { return actions }
        var result = KeyboardAction.Rows()
        result.append(topLeadingActions(for: context) + actions[0] + topTrailingActions(for: context))
        result.append(middleLeadingActions(for: context) + actions[1] + middleTrailingActions(for: context))
        result.append(lowerLeadingActions(for: context) + actions[2] + lowerTrailingActions(for: context))
        result.append(bottomActions(for: context))
        return result
    }

    open override func itemSizeWidth(
        for action: KeyboardAction,
        row: Int,
        index: Int,
        context: KeyboardContext
    ) -> KeyboardLayout.ItemWidth {
        if isLowerTrailingSwitcher(action, row: row, index: index) { return .available }
        switch action {
        case context.keyboardDictationReplacement: return .input
        case .none: return .inputPercentage(0.4)
        case .primary: return .available
        default: break
        }
        if action.isSystemAction { return systemButtonWidth(for: context) }
        return super.itemSizeWidth(for: action, row: row, index: index, context: context)
    }

    open override func keyboardReturnAction(
        for context: KeyboardContext
    ) -> KeyboardAction {
        let base = super.keyboardReturnAction(for: context)
        return base == .primary(.return) ? .primary(.newLine) : base
    }


    // MARK: - iPad Specific

    /// Leading actions to add to the top input row.
    open func topLeadingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        []
    }

    /// Trailing actions to add to the top input row.
    open func topTrailingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        [.backspace]
    }

    /// Leading actions to add to the middle input row.
    open func middleLeadingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        return [.none]
    }

    /// Trailing actions to add to the middle input row.
    open func middleTrailingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        [keyboardReturnAction(for: context)]
    }

    /// Leading actions to add to the lower input row.
    open func lowerLeadingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [action]
    }

    /// Trailing actions to add to the lower input row.
    open func lowerTrailingActions(
        for context: KeyboardContext
    ) -> KeyboardAction.Row {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [action]
    }

    /// The actions to add to the bottom system row.
    open func bottomActions(for context: KeyboardContext) -> KeyboardAction.Row {
        var result = KeyboardAction.Row()
        let needsDictation = context.needsInputModeSwitchKey
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        result.append(.nextKeyboard)
        if needsDictation, let action = context.keyboardDictationReplacement { result.append(action) }
        result.append(.space)
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        result.append(.dismissKeyboard)
        return result
    }
    
    /// The standard system button width for a context.
    open func systemButtonWidth(
        for context: KeyboardContext
    ) -> KeyboardLayout.ItemWidth {
        .input
    }
}


// MARK: - Private utils

extension iPadKeyboardLayoutProvider {
    
    func isLowerLeadingSwitcher(
        _ action: KeyboardAction,
        row: Int,
        index: Int
    ) -> Bool {
        switch action {
        case .shift, .keyboardType: row == 2 && index == 0
        default: false
        }
    }
    
    func isLowerTrailingSwitcher(
        _ action: KeyboardAction,
        row: Int,
        index: Int
    ) -> Bool {
        switch action {
        case .shift, .keyboardType: row == 2 && index > 0
        default: false
        }
    }
}


#Preview {
    
    func layout() -> KeyboardLayout {
        iPadKeyboardLayoutProvider(
            alphabeticInputSet: .qwerty,
            numericInputSet: .standardNumeric(currency: "$"),
            symbolicInputSet: .standardSymbolic(currencies: [""])
        ).keyboardLayout(for: .preview)
    }
    
    return SystemKeyboard(
        layout: layout(),
        actionHandler: .preview,
        styleProvider: .preview,
        keyboardContext: .preview,
        autocompleteContext: .preview,
        calloutContext: .preview,
        buttonContent: { $0.view },
        buttonView: { $0.view },
        emojiKeyboard: { $0.view },
        toolbar: { $0.view}
    )
    .background(Color.keyboardBackground)
}
