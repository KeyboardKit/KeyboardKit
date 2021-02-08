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
 
 `TODO` This class is currently used for iPad Air/Pro. These
 device types should use a different layout.
 
 `TODO` This class sizes buttons according to their expected
 size on an English keyboard. Other locales and orientations
 may need customizations.

 `IMPORTANT` This layout provider has only been tested for a
 couple of locales. If you create a new input set and use it
 with this layout, you may find that buttons are incorrectly
 sized or placed. If so, create a new layout provider either
 from scratch or by inheriting this one. Also, open an issue
 if you think that a supported locale get the wrong size.
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

struct iPadKeyboardLayoutProvider_Previews: PreviewProvider {
    
    static var context = ObservableKeyboardContext.preview
    
    static var input = StandardKeyboardInputSetProvider(context: context)
    
    static var layout = iPadKeyboardLayoutProvider(inputSetProvider: input)
    
    static func previews(for locale: Locale, title: String) -> some View {
        ScrollView {
            Text(title).font(.title)
            preview(for: locale, type: .alphabetic(.lowercased))
            preview(for: locale, type: .numeric)
            preview(for: locale, type: .symbolic)
        }.padding()
    }
    
    static func preview(for locale: Locale, type: KeyboardType) -> some View {
        context.locale = locale
        context.keyboardType = type
        return VStack {
            SystemKeyboard(
                layout: layout.keyboardLayout(for: context),
                appearance: StandardKeyboardAppearance(context: context),
                actionHandler: PreviewKeyboardActionHandler(),
                width: 768)
                .frame(width: 768)
                .environmentObject(context)
                .environmentObject(InputCalloutContext.preview)
                .environmentObject(SecondaryInputCalloutContext.preview)
                .background(Color.gray)
            
        }
    }
    
    static var previews: some View {
        Group {
            previews(for: LocaleKey.english.locale, title: "English")
            previews(for: LocaleKey.german.locale, title: "German")
            previews(for: LocaleKey.italian.locale, title: "Italian")
            previews(for: LocaleKey.swedish.locale, title: "Swedish")
        }.previewLayout(.sizeThatFits)
    }
}
