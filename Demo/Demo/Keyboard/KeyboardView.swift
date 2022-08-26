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
 This is the main view that is registered when the extension
 calls `setup(with:)` in `KeyboardViewController`.
 
 The view must observe the KeyboardContext as an environment
 object or inject an instance and then set it to an observed
 object (commented out). Otherwise this view will not change
 when the context changes.
 */
struct KeyboardView: View {
    
    @State private var text = "Text"
    
    @EnvironmentObject private var context: KeyboardContext
    
    var body: some View {
        VStack(spacing: 0) {
            if context.keyboardType != .emojis {
                DemoAutocompleteToolbar()
            }
            SystemKeyboard()
        }
    }
}


// MARK: - Private Views

private extension KeyboardView {
    
    var textField: some View {
        KeyboardTextField(text: $text) {
            $0.placeholder = "Try typing here, press return to stop."
            $0.borderStyle = .roundedRect
            $0.autocapitalizationType = .sentences
        }.padding(3)
    }
}
