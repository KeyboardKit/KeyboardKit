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
 */
struct KeyboardView: View {
    
    var keyboardActionHandler: KeyboardActionHandler
    var keyboardAppearance: KeyboardAppearance
    var keyboardLayoutProvider: KeyboardLayoutProvider
    
    @EnvironmentObject var autocompleteContext: ObservableAutocompleteContext
    @EnvironmentObject var keyboardContext: ObservableKeyboardContext
    @EnvironmentObject var toastContext: KeyboardToastContext
    
    var body: some View {
        keyboardView.keyboardToast(
            context: toastContext,
            background: toastBackground)
    }
    
    @ViewBuilder
    var keyboardView: some View {
        switch keyboardContext.keyboardType {
        case .alphabetic, .numeric, .symbolic: systemKeyboard
        case .emojis: emojiKeyboard
        case .images: imageKeyboard
        default: Button("???", action: switchToDefaultKeyboard)
        }
    }
}


// MARK: - Private Views

private extension KeyboardView {
    
    var autocompleteBar: some View {
        HStack {
            AutocompleteToolbar(
                suggestions: autocompleteContext.suggestions,
                buttonBuilder: autocompleteBarButtonBuilder)
            Spacer()
            settingsButton
        }.frame(height: 50)
    }
    
    func autocompleteBarButton(for suggestion: AutocompleteSuggestion) -> AnyView {
        guard let subtitle = suggestion.subtitle else { return AutocompleteToolbar.standardButton(for: suggestion) }
        return AnyView(VStack(spacing: 0) {
            Text(suggestion.title).font(.callout)
            Text(subtitle).font(.footnote)
        }.frame(maxWidth: .infinity))
    }
    
    func autocompleteBarButtonBuilder(suggestion: AutocompleteSuggestion) -> AnyView {
        AnyView(autocompleteBarButton(for: suggestion)
                    .background(Color.clearInteractable))
    }
    
    @ViewBuilder
    var emojiKeyboard: some View {
        if #available(iOSApplicationExtension 14.0, *) {
            EmojiCategoryKeyboard().padding(.vertical)
        } else {
            Text("Requires iOS 14 or later")
        }
    }
    
    var imageKeyboard: some View {
        ImageKeyboard(
            actionHandler: keyboardActionHandler,
            appearance: keyboardAppearance)
            .padding()
    }
    
    var settingsButton: some View {
        Image.settings
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(5)
            .keyboardButtonStyle(for: .character(""), appearance: keyboardAppearance)
            .padding(.standardKeyboardButtonInsets())
            .onTapGesture {
                changeLocale(to: .swedish)
            }
            .contextMenu {
                localeButton(title: "English", locale: .english)
                localeButton(title: "German", locale: .german)
                localeButton(title: "Italian", locale: .italian)
                localeButton(title: "Swedish", locale: .swedish)
            }
    }
    
    var systemKeyboard: some View {
        VStack(spacing: 0) {
            autocompleteBar
            SystemKeyboard(
                layout: keyboardLayoutProvider.keyboardLayout(for: keyboardContext),
                appearance: keyboardAppearance,
                actionHandler: keyboardActionHandler,
                buttonBuilder: buttonBuilder)
        }
    }
    
    var toastBackground: some View {
        Color.white
            .cornerRadius(3)
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 1, y: 1)
    }
}


// MARK: - Private Functions

private extension KeyboardView {
    
    func buttonBuilder(action: KeyboardAction, size: CGSize) -> AnyView {
        switch action {
        case .space: return AnyView(SystemKeyboardSpaceButtonContent(localeText: "English", spaceText: "space"))
        default: return SystemKeyboard.standardButtonBuilder(action: action, keyboardSize: size)
        }
    }
    
    func changeLocale(to locale: LocaleKey) {
        DispatchQueue.main.async {
            keyboardInputViewController.changeKeyboardLocale(to: locale.locale)
        }
    }
    
    func localeButton(title: String, locale: LocaleKey) -> some View {
        Button(title) {
            changeLocale(to: locale)
        }
    }
    
    func switchToDefaultKeyboard() {
        keyboardActionHandler
            .handle(.tap, on: .keyboardType(.alphabetic(.lowercased)))
    }
}
