//
//  KeyboardView.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2020-06-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit

/**
 This view is the main view that is used by the extension by
 calling `setup(with:)` in `KeyboardViewController`.
 
 The view will switch over the current keyboard type and add
 the correct keyboard view.
 
 Set `addTextFieldAboveKeyboard` to true to add a text field
 above the demo keyboard. This text field will automatically
 take over as the main proxy instead of the main app.
 */
struct KeyboardView: View {
    
    let addTextFieldAboveKeyboard = false
    
    let actionHandler: KeyboardActionHandler
    let appearance: KeyboardAppearance
    let layoutProvider: KeyboardLayoutProvider
    
    @State private var text = "Text"
    
    @EnvironmentObject private var keyboardContext: KeyboardContext
    @EnvironmentObject private var inputContext: InputCalloutContext
    @EnvironmentObject private var secondaryInputContext: SecondaryInputCalloutContext
    
    var body: some View {
        switch keyboardContext.keyboardType {
        case .alphabetic, .numeric, .symbolic: systemKeyboardStack
        case .emojis: emojiKeyboard
        default: Button("Unsupported keyboard", action: switchToDefaultKeyboard)
        }
    }
}


// MARK: - Private Views

private extension KeyboardView {
    
    @ViewBuilder
    var emojiKeyboard: some View {
        if #available(iOSApplicationExtension 14.0, *) {
            EmojiCategoryKeyboard(
                appearance: appearance,
                context: keyboardContext)
                .padding(.vertical)
        } else {
            Text("Requires iOS 14 or later")
        }
    }
    
    var systemKeyboard: some View {
        SystemKeyboard(
            layout: layoutProvider.keyboardLayout(for: keyboardContext),
            appearance: appearance,
            actionHandler: actionHandler,
            context: keyboardContext,
            inputContext: inputContext,
            secondaryInputContext: secondaryInputContext,
            buttonBuilder: buttonBuilder)
    }
    
    var systemKeyboardStack: some View {
        VStack(spacing: 0) {
            DemoAutocompleteToolbar()
            if addTextFieldAboveKeyboard {
                textField
            }
            systemKeyboard
        }
    }
    
    var textField: some View {
        KeyboardTextField(text: $text, config: {
            $0.placeholder = "Try typing here, press return to stop."
            $0.borderStyle = .roundedRect
            $0.autocapitalizationType = .sentences
        }).padding(3)
    }
}


// MARK: - Private Functions

private extension KeyboardView {
    
    func buttonBuilder(
        action: KeyboardAction,
        appearance: KeyboardAppearance) -> AnyView {
        switch action {
        case .space: return AnyView(SystemKeyboardSpaceButtonContent(
            localeText: keyboardContext.locale.localizedLanguageName ?? "",
            spaceText: KKL10n.space.text(for: keyboardContext.locale)
        ))
        default: return SystemKeyboard
                .standardButtonBuilder(action: action, appearance: appearance)
        }
    }
    
    func switchToDefaultKeyboard() {
        actionHandler
            .handle(.tap, on: .keyboardType(.alphabetic(.lowercased)))
    }
}
