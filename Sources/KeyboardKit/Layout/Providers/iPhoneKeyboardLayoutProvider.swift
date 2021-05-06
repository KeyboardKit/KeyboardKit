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
 
 This provider will return an `itemSize` that corresponds to
 how a certain action is sized on an English system keyboard.
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
        if action.isPrimaryAction { return bottomRowPrimaryButtonWidth }
        switch action {
        case dictationReplacement: return bottomRowSystemButtonWidth
        case .character: return isLastNumericInputRow(row, for: context) ? lastSymbolicInputWidth : .input
        case .backspace: return thirdRowSystemButtonWidth
        case .keyboardType: return bottomRowSystemButtonWidth
        case .newLine: return bottomRowPrimaryButtonWidth
        case .nextKeyboard: return bottomRowSystemButtonWidth
        case .return: return bottomRowPrimaryButtonWidth
        case .shift: return thirdRowSystemButtonWidth
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
        let portrait = context.deviceOrientation.isPortrait
        let needsInputSwitcher = context.needsInputModeSwitchKey
        let needsDictation = context.needsInputModeSwitchKey
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        if needsInputSwitcher { result.append(.nextKeyboard) }
        if !needsInputSwitcher { result.append(.keyboardType(.emojis)) }
        if portrait, needsDictation, let action = dictationReplacement { result.append(action) }
        result.append(.space)
        result.append(keyboardReturnAction(for: context))
        if !portrait, needsDictation, let action = dictationReplacement { result.append(action) }
        return result
    }
    
    open func lowerLeadingActions(for context: KeyboardContext) -> KeyboardActions {
        guard let action = keyboardSwitchActionForBottomInputRow(for: context) else { return [] }
        return [action, .none]
    }
    
    open func lowerTrailingActions(for context: KeyboardContext) -> KeyboardActions {
        [.none, .backspace]
    }
}

private extension iPhoneKeyboardLayoutProvider {
    
    /**
     The width of the last numeric/symbolic row input button.
     */
    var lastSymbolicInputWidth: KeyboardLayoutItemWidth { .percentage(0.14) }
    
    /**
     The width of the bottom-right primary (return) button.
     */
    var bottomRowPrimaryButtonWidth: KeyboardLayoutItemWidth { .percentage(0.25) }
    
    /**
     The width of the bottom-right primary (return) button.
     */
    var bottomRowSystemButtonWidth: KeyboardLayoutItemWidth { .percentage(0.125) }
    
    /**
     The system buttons that are shown to the left and right
     of the third row's input buttons.
     */
    var thirdRowSystemButtonWidth: KeyboardLayoutItemWidth { .percentage(0.13) }
    
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

struct iPhoneKeyboardLayoutProvider_Previews: PreviewProvider {
    
    static var overlayOpacity: Double = 1.0
    static var previewWidth: CGFloat = 390
    
    static var context = KeyboardContext(
        device: MockDevice(),
        controller: KeyboardInputViewController(),
        keyboardType: .alphabetic(.lowercased))
    
    static var proxy = PreviewTextDocumentProxy()
    
    static var image: some View {
        Image(imageName, bundle: .module)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: previewWidth)
            .opacity(overlayOpacity)
    }
    
    static var imageName: String {
        "iPhone12_\(context.locale.languageCode ?? "")_\(imageNameSuffix)"
    }
    
    static var imageNameSuffix: String {
        switch context.keyboardType {
        case .alphabetic: return "alphabetic"
        case .numeric: return "numeric"
        case .symbolic: return "numeric"
        default: return ""
        }
    }
    
    static func input(for locale: KeyboardLocale) -> KeyboardInputSetProvider {
        StandardKeyboardInputSetProvider(
            context: context,
            providers: [provider(for: locale)])
    }
    
    static func layout(for locale: KeyboardLocale) -> KeyboardLayoutProvider {
        iPhoneKeyboardLayoutProvider(inputSetProvider: input(for: locale))
    }
    
    static func provider(for locale: KeyboardLocale) -> LocalizedKeyboardInputSetProvider {
        switch locale {
        case .swedish: return SwedishKeyboardInputSetProvider(device: MockDevice())
        default: return EnglishKeyboardInputSetProvider(device: MockDevice())
        }
    }
    
    static func preview(for locale: KeyboardLocale, type: KeyboardType) -> some View {
        //proxy.returnKeyType = UIReturnKeyType.search
        context.locale = locale.locale
        context.keyboardType = type
        context.textDocumentProxy = proxy
        context.needsInputModeSwitchKey = true
        return SystemKeyboard(
            layout: layout(for: locale).keyboardLayout(for: context),
            appearance: StandardKeyboardAppearance(context: context),
            actionHandler: PreviewKeyboardActionHandler(),
            width: previewWidth)
            .environmentObject(context)
            .environmentObject(InputCalloutContext.preview)
            .environmentObject(SecondaryInputCalloutContext.preview)
            .background(image, alignment: .bottom)
            .background(Color.gray.opacity(0.4))
    }
    
    static func previews(for locale: KeyboardLocale) -> some View {
        VStack {
            Text(locale.localizedName).font(.title)
            preview(for: locale, type: .alphabetic(.lowercased))
            preview(for: locale, type: .alphabetic(.uppercased))
            preview(for: locale, type: .numeric)
            preview(for: locale, type: .symbolic)
        }.padding()
    }
    
    static var previews: some View {
        ScrollView {
            HStack {
                previews(for: .english)
                previews(for: .swedish)
            }
        }
        .frame(height: 980)
        .previewLayout(.sizeThatFits)
    }
}

private class MockDevice: UIDevice {
    
    override var userInterfaceIdiom: UIUserInterfaceIdiom { .phone }
}
