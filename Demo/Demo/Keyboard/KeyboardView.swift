//
//  KeyboardView.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2020-06-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This is the main demo keyboard view, which is registered by
 ``KeyboardViewController`` in all `SystemKeyboard` demos.

 This view will add an autocomplete toolbar above the system
 keyboard, if the keyboard type isn't emojis. The toolbar is
 hidden if the keyboard shouldn't have autocomplete, but the
 height is still allocated, since the callouts need it.
 
 The view must observe a `KeyboardContext` as an environment
 object, or take a context instance as an init parameter and
 set it to an observed object. Otherwise, it will not change
 when the context changes. This is not how it should be, but
 I have not yet figured out why this is needed.
 */
struct KeyboardView: View {
    
    @EnvironmentObject
    private var autocompleteContext: AutocompleteContext

    @EnvironmentObject
    private var keyboardContext: KeyboardContext
    @EnvironmentObject
    private var keyboardTextContext: KeyboardTextContext
    
    var body: some View {
        VStack(spacing: 0) {
            if keyboardContext.keyboardType != .emojis {
                autocompleteToolbar
            }
            SystemKeyboard()
        }
    }
}


// MARK: - Private Views

private extension KeyboardView {

    var autocompleteToolbar: some View {
        AutocompleteToolbar(
            suggestions: autocompleteContext.suggestions,
            locale: keyboardContext.locale
        ).opacity(keyboardContext.prefersAutocomplete ? 1 : 0)  // Still allocate height
    }
}
