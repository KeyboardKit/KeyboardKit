//
//  KeyboardView+Keyboards.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2021-01-09.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import KeyboardKitSwiftUI
import SwiftUI

extension KeyboardView {
    
    var emojiKeyboard: some View {
        EmojiKeyboard()
            .padding()
    }
    
    var imageKeyboard: some View {
        ImageKeyboard()
            .padding()
    }
    
    var systemKeyboard: some View {
        VStack(spacing: 0) {
            AutocompleteToolbar().frame(height: 50)
            SystemKeyboard(layout: systemKeyboardLayout)
        }
    }
    
    var systemKeyboardLayout: KeyboardLayout {
        context.keyboardLayoutProvider.keyboardLayout(for: context)
    }
    
    var toastBackground: some View {
        Color.white
            .cornerRadius(3)
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 1, y: 1)
    }
}
