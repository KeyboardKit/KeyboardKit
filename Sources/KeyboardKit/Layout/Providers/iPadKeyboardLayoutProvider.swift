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
 a home button and adds iPad-specific buttons around a basic
 set of input actions.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 This provider will return an `itemSize` that corresponds to
 how a certain action is sized on an English system keyboard.
 
 `TODO` This provider is currently used for iPad Air and Pro
 devices as well, although they should use different layouts.
 */
open class iPadKeyboardLayoutProvider: SystemKeyboardLayoutProvider {
    
    
    // MARK: - Overrides
    
    /**
     Get keyboard actions for the given context and inputs.
     
     The provider will only adjust the base class actions if
     they consist of three rows or more.
     */
    open override func actions(for context: KeyboardContext, inputs: KeyboardInputRows) -> KeyboardActionRows {
        var actions = super.actions(for: context, inputs: inputs)
        guard actions.count > 2 else { return actions }
        let last = actions.suffix(3)
        actions.removeLast(3)
        actions.append(last[0] + [.backspace])
        actions.append([.none] + last[1] + [keyboardReturnAction(for: context)])
        actions.append(lowerLeadingActions(for: context) + last[2] + lowerTrailingActions(for: context))
        actions.append(bottomActions(for: context))
        return actions
    }
    
    open override func itemSizeWidth(for context: KeyboardContext, action: KeyboardAction, row: Int, index: Int) -> KeyboardLayoutItemWidth {
        let elevenElevenSeven = hasElevenElevenSevenAlphabeticInput
        if isSecondRowSpacer(action, row: row, index: index) { return .inputPercentage(elevenElevenSeven ? 0.3 : 0.4) }
        if isThirdRowLeadingSwitcher(action, row: row, index: index) { return elevenElevenSeven ? .inputPercentage(1.1) : .input }
        if isThirdRowTrailingSwitcher(action, row: row, index: index) { return .available }
        if isBottomRowLeadingSwitcher(action, row: row, index: index) { return .input }
        if isBottomRowTrailingSwitcher(action, row: row, index: index) { return .inputPercentage(1.45) }
        switch action {
        case dictationReplacement: return .input
        case .backspace: return .percentage(elevenElevenSeven ? 0.125 : 0.095)
        case .dismissKeyboard: return .inputPercentage(1.45)
        case .keyboardType: return row == 2 ? .available : .input
        case .nextKeyboard: return .input
        default: return super.itemSizeWidth(for: context, action: action, row: row, index: index)
        }
    }
    
    
    // MARK: - iPad Specific
    
    open override func keyboardReturnAction(for context: KeyboardContext) -> KeyboardAction {
        let base = super.keyboardReturnAction(for: context)
        return base == .return ? .newLine : base
    }
    
    /**
     Get the actions that should be bottommost on a keyboard
     that uses the standard iPad system layout.
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
        device: MockDevice(),
        controller: KeyboardInputViewController(),
        keyboardType: .alphabetic(.lowercased))
    
    static var previewImage: some View {
        Image(context.previewImageName, bundle: .module)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: context.previewWidth)
            .opacity(0.8)
    }

    
    static func input(for locale: KeyboardLocale) -> KeyboardInputSetProvider {
        StandardKeyboardInputSetProvider(
            context: context,
            providers: [provider(for: locale)])
    }
    
    static func layout(for locale: KeyboardLocale) -> KeyboardLayoutProvider {
        iPadKeyboardLayoutProvider(inputSetProvider: input(for: locale))
    }
    
    static func provider(for locale: KeyboardLocale) -> LocalizedKeyboardInputSetProvider {
        switch locale {
        case .swedish: return InternalSwedishKeyboardInputSetProvider(device: MockDevice())
        default: return EnglishKeyboardInputSetProvider(device: MockDevice())
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
            actionHandler: PreviewKeyboardActionHandler(),
            width: context.previewWidth)
            .keyboardPreview(context: context)
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
