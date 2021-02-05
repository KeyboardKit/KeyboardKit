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


// MARK: - Functions

private extension KeyboardView {
    
    @ViewBuilder
    var emojiKeyboard: some View {
        if #available(iOSApplicationExtension 14.0, *) {
            EmojiCategoryKeyboard().padding(.vertical)
        } else {
            Text("Requires iOS 14 or later")
        }
    }
    
    func switchToDefaultKeyboard() {
        keyboardActionHandler
            .handle(.tap, on: .keyboardType(.alphabetic(.lowercased)))
    }
    
    var toastBackground: some View {
        Color.white
            .cornerRadius(3)
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 1, y: 1)
    }
}
