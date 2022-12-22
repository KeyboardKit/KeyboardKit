//
//  KeyboardView.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2020-06-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/**
 This is the main view that is registered when the extension
 calls `setup(with:)` in `KeyboardViewController`.
 
 The view must observe the KeyboardContext as an environment
 object or inject an instance and then set it to an observed
 object (commented out). Otherwise this view will not change
 when the context changes.
 */
struct KeyboardView: View {
    
    @EnvironmentObject
    private var autocompleteContext: AutocompleteContext

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    @AppStorage("com.keyboardkit.demo.pro.locale")
    private var localeIdentifier = "en"
    
    var body: some View {
        VStack(spacing: 0) {
            if keyboardContext.keyboardType != .emojis {
                autocompleteToolbar
            }
            SystemKeyboard()
        }
        .onAppear(perform: restoreLastLocale)
        .onReceive(keyboardContext.$locale, perform: persistLocale)
    }
}

private extension KeyboardView {

    func restoreLastLocale() {
        let locale = Locale(identifier: localeIdentifier)
        keyboardContext.locale = locale
    }

    func persistLocale(_ locale: Locale) {
        localeIdentifier = locale.identifier
    }
}

private extension KeyboardView {

    var autocompleteToolbar: some View {
        AutocompleteToolbar(
            suggestions: autocompleteContext.suggestions,
            locale: keyboardContext.locale
        ).opacity(keyboardContext.prefersAutocomplete ? 1 : 0)  // Still allocate height
    }
}
