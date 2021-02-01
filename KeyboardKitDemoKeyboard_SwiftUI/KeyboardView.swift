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
    @EnvironmentObject var context: ObservableKeyboardContext
    @EnvironmentObject var toastContext: KeyboardToastContext
    
    var body: some View {
        keyboardView
            .keyboardToast(isActive: $toastContext.isActive, content: toastContext.content, background: toastBackground)
    }
    
    @ViewBuilder
    var keyboardView: some View {
        switch context.keyboardType {
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
            EmojiCategoryKeyboard().padding(.top)
        } else {
            Text("Requires iOS 14 or later")
        }
    }
    
    func switchToDefaultKeyboard() {
        keyboardActionHandler
            .handle(.tap, on: .keyboardType(.alphabetic(.lowercased)))
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(
            keyboardActionHandler: FakeKeyboardActionHandler(),
            keyboardAppearance: StandardKeyboardAppearance(context: FakeKeyboardContext()),
            keyboardLayoutProvider: StandardKeyboardLayoutProvider())
    }
}
