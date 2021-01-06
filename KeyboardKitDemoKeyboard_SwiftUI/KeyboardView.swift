//
//  KeyboardView.swift
//  KeyboardKitDemoKeyboard_SwiftUI
//
//  Created by Daniel Saidi on 2020-06-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit
import KeyboardKitSwiftUI

/**
 This view is the main view that is used by the extension by
 calling `setup(with:)` in `KeyboardViewController`.
 
 The view will switch over the current keyboard type and add
 the correct keyboard view.
 
 `TODO` Add support for emoji keyboard, once lazy stacks are
 supported. Now, the app crashes due to memory pressure.
 */
struct KeyboardView: View {
    
    let controller: KeyboardInputViewController
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
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
        default: Button("This keyboard is not yet implemented", action: switchToDefaultKeyboard)
        }
    }
}


// MARK: - Views

private extension KeyboardView {
    
    var emojiKeyboard: some View {
        EmojiKeyboard()
            .padding()
    }
    
    var imageKeyboard: some View {
        ImageKeyboard()
            .padding()
    }
    
    var systemKeyboard: some View {
        VStack {
            AutocompleteToolbar().frame(height: 45)
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


// MARK: - Functions

private extension KeyboardView {
    
    func switchToDefaultKeyboard() {
        context.actionHandler
            .handle(.tap, on: .keyboardType(.alphabetic(.lowercased)))
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(controller: KeyboardInputViewController())
    }
}
