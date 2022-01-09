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
 
 `TODO` The layout specifics are pretty nasty below, but the
 internal functionality can be extracted to the new keyboard
 layout configuration type or expressed outside this class.
 */
open class iPadKeyboardLayoutProvider: SystemKeyboardLayoutProvider {
    
    
    // MARK: - Overrides
    
    /**
     Get keyboard actions for the provided `context` and the
     provided keyboard `inputs`.
     
     This provider will only adjust the base actions if they
     consist of three rows or more.
     */
    open override func actions(for context: KeyboardContext, inputs: InputSetRows) -> KeyboardActionRows {
        var actions = super.actions(for: context, inputs: inputs)
        guard actions.count > 2 else { return actions }
        let last = actions.suffix(3)
        actions.removeLast(3)
        actions.append(topLeadingActions(for: context) + last[0] + topTrailingActions(for: context))
        actions.append(middleLeadingActions(for: context) + last[1] + middleTrailingActions(for: context))
        actions.append(lowerLeadingActions(for: context) + last[2] + lowerTrailingActions(for: context))
        actions.append(bottomActions(for: context))
        return actions
    }
    
    /**
     Get the keyboard layout item width of a certain `action`
     for the provided `context`, `row` and row `index`.
     */
    open override func itemSizeWidth(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutItemWidth {
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
        case .backspace: return .percentage(elevenEleven ? 0.125 : 0.095)
        case .dismissKeyboard: return .inputPercentage(1.45)
        case .keyboardType: return row == 2 ? .available : .input
        case .nextKeyboard: return .input
        case .newLine:
            if isBelarusianAlphabetic(context) { return .available }
        default: break
        }
        return super.itemSizeWidth(for: context, action: action, row: row, index: index)
        
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

/**
 These previews are pretty complex, since we want to be able
 to verify that the returned sizes are correct. We therefore
 add a real screenshot below the generated SwiftUI view.
 
 The real screenshots are not perfectly cropped to fit these
 previews, but they give a great assistance in approximating
 the size, so that it's not way off.
 */
struct iPadKeyboardLayoutProvider_Previews: PreviewProvider {
    
    static var proxy = PreviewTextDocumentProxy()
    
    static var context = KeyboardContext(
        controller: KeyboardInputViewController(),
        device: MockDevice(),
        keyboardType: .alphabetic(.lowercased))
    
    static var previewImage: some View {
        Image(context.previewImageName, bundle: .module)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: context.previewWidth)
            .opacity(0.8)
    }

    
    static func input(for locale: KeyboardLocale) -> InputSetProvider {
        StandardInputSetProvider(
            context: context,
            providers: [provider(for: locale)])
    }
    
    static func layout(for locale: KeyboardLocale) -> KeyboardLayoutProvider {
        iPadKeyboardLayoutProvider(inputSetProvider: input(for: locale))
    }
    
    static func provider(for locale: KeyboardLocale) -> LocalizedInputSetProvider {
        switch locale {
        case .swedish: return InternalSwedishInputSetProvider(device: MockDevice())
        default: return EnglishInputSetProvider(device: MockDevice())
        }
    }
    
    
    static func preview(for locale: KeyboardLocale, _ type: KeyboardType, _ orientation: UIInterfaceOrientation) -> some View {
        // proxy.returnKeyType = UIReturnKeyType.search
        context.locale = locale.locale
        context.keyboardType = type
        context.screenOrientation = orientation
        context.textDocumentProxy = proxy
        context.needsInputModeSwitchKey = true
        return SystemKeyboard(
            layout: layout(for: locale).keyboardLayout(for: context),
            appearance: StandardKeyboardAppearance(context: context),
            actionHandler: .preview,
            keyboardContext: .preview,
            actionCalloutContext: .preview,
            inputCalloutContext: .preview,
            width: context.previewWidth)
            .background(previewImage)
            .background(Color.gray)
    }
    
    static func previews(for locale: KeyboardLocale, _ orientation: UIInterfaceOrientation) -> some View {
        VStack {
            Text(locale.localizedName).font(.title)
            preview(for: locale, .alphabetic(.lowercased), orientation)
            preview(for: locale, .alphabetic(.uppercased), orientation)
            preview(for: locale, .numeric, orientation)
            preview(for: locale, .symbolic, orientation)
            Spacer()
        }.padding()
    }
    
    static var previews: some View {
        HStack {
            previews(for: .english, .portrait)
            previews(for: .swedish, .portrait)
            previews(for: .english, .landscapeLeft)
            previews(for: .swedish, .landscapeLeft)
        }
        .frame(height: 1600)
        .previewLayout(.sizeThatFits)
    }
}

private class MockDevice: UIDevice {
    
    override var userInterfaceIdiom: UIUserInterfaceIdiom { .pad }
}

private extension KeyboardContext {
    
    var previewImageName: String {
        let language = locale.languageCode ?? ""
        let type = keyboardType.previewImageSegment
        let orientation = screenOrientation.previewImageSegment
        return "iPad_\(language)_\(type)_\(orientation)"
    }
    
    var previewWidth: CGFloat {
        screenOrientation.isPortrait ? 768 : 1024
    }
}

private extension KeyboardType {
    
    var previewImageSegment: String {
        switch self {
        case .alphabetic: return "alphabetic"
        case .numeric: return "numeric"
        case .symbolic: return "numeric"
        default: return ""
        }
    }
}

private extension UIInterfaceOrientation {
    
    var previewImageSegment: String {
        isPortrait ? "portrait" : "landscape"
    }
}
