//
//  KeyboardView.swift
//  KeyboardKitDemo
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
        case .emojis: EmojiCategoryKeyboard().padding(.top)
        case .images: imageKeyboard
        default: Button("???", action: switchToDefaultKeyboard)
        }
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
        KeyboardView()
    }
}
