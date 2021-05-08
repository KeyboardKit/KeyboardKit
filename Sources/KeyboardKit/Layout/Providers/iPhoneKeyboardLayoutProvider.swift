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
     Get keyboard actions for the given context and inputs.
     
     The provider will only adjust the base class actions if
     they consist of at least one row.
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
        if action.isPrimaryAction { return bottomRowPrimaryButtonWidth(for: context) }
        switch action {
        case dictationReplacement: return bottomRowSystemButtonWidth(for: context)
        case .character: return isLastNumericInputRow(row, for: context) ? lastSymbolicInputWidth(for: context) : .input
        case .backspace: return thirdRowSystemButtonWidth(for: context)
        case .keyboardType: return bottomRowSystemButtonWidth(for: context)
        case .newLine: return bottomRowPrimaryButtonWidth(for: context)
        case .nextKeyboard: return bottomRowSystemButtonWidth(for: context)
        case .return: return bottomRowPrimaryButtonWidth(for: context)
        case .shift: return thirdRowSystemButtonWidth(for: context)
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
        let portrait = context.screenOrientation.isPortrait
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
    func bottomRowPrimaryButtonWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        .percentage(isPortrait(context) ? 0.25 : 0.195)
    }
    
    /**
     The width of the bottom-right primary (return) button.
     */
    func bottomRowSystemButtonWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        .percentage(isPortrait(context) ? 0.125 : 0.097)
    }
    
    /**
     The system buttons that are shown to the left and right
     of the third row's input buttons.
     */
    func thirdRowSystemButtonWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        .percentage(0.13)
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
}

/**
 These previews are pretty complex, since we want to be able
 to verify that the returned sizes are correct. We therefore
 add a real screenshot below the generated SwiftUI view.
 
 The real screenshots are not perfectly cropped to fit these
 previews, but they give a great assistance in approximating
 the size, so that it's not way off.
 */
struct iPhoneKeyboardLayoutProvider_Previews: PreviewProvider {
    
    static var overlayOpacity: Double = 1.0
    
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
            .opacity(overlayOpacity)
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
            .environmentObject(context)
            .environmentObject(InputCalloutContext.preview)
            .environmentObject(SecondaryInputCalloutContext.preview)
            .background(previewImage, alignment: .bottom)
            .background(Color.gray.opacity(0.4))
            .overlay(Text(context.previewImageName), alignment: .bottom)
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
        .frame(height: 980)
        .previewLayout(.sizeThatFits)
    }
}

private class MockDevice: UIDevice {
    
    override var userInterfaceIdiom: UIUserInterfaceIdiom { .phone }
}

private extension KeyboardContext {
    
    var previewImageName: String {
        let language = locale.languageCode ?? ""
        let keyboardType = keyboardType.previewImageSegment
        let orientation = screenOrientation.previewImageSegment
        return "iPhone12_\(language)_\(keyboardType)_\(orientation)"
    }
    
    var previewWidth: CGFloat {
        screenOrientation.isPortrait ? 390 : 844
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
