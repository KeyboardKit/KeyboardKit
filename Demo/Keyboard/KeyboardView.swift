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
        
    @State private var text = "Text"
    
    @EnvironmentObject private var actionCalloutContext: ActionCalloutContext
    @EnvironmentObject private var keyboardContext: KeyboardContext
    @EnvironmentObject private var inputCalloutContext: InputCalloutContext
    
    var body: some View {
        VStack(spacing: 0) {
            if keyboardContext.keyboardType != .emojis {
                DemoAutocompleteToolbar()
            }
            SystemKeyboard()
        }
    }
}


// MARK: - Private Views

private extension KeyboardView {
    
    var systemKeyboard: some View {
        SystemKeyboard()
    }
    
    var textField: some View {
        KeyboardTextField(text: $text) {
            $0.placeholder = "Try typing here, press return to stop."
            $0.borderStyle = .roundedRect
            $0.autocapitalizationType = .sentences
        }.padding(3)
    }
}


// MARK: - Private Functions

private extension KeyboardView {
    
    func switchToDefaultKeyboard() {
        keyboardContext.keyboardType = .alphabetic(.lowercased)
    }
}
