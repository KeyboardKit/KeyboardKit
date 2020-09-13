//
//  KeyboardView.swift
//  KeyboardKitDemoKeyboard_SwiftUI
//
//  Created by Daniel Saidi on 2020-06-10.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
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
 
 `TODO` Move the `keyboardView` switch into `body` after the
 projects has been upgraded to Swift 5.3.
 */
struct KeyboardView: View {
    
    init(controller: KeyboardInputViewController) {
        self.controller = controller
    }
    
    private let controller: KeyboardInputViewController
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var context: ObservableKeyboardContext
    @EnvironmentObject var toastContext: KeyboardToastContext
    
    var body: some View {
        keyboardView
            .keyboardToast(isActive: $toastContext.isActive, content: toastContext.content, background: toastBackground)
    }
    
    var keyboardView: AnyView {
        switch context.keyboardType {
        case .alphabetic(let state): return AnyView(alphabeticKeyboard(state))
        case .emojis: return AnyView(emojiKeyboard)
        case .images: return AnyView(imageKeyboard)
        case .numeric: return AnyView(numericKeyboard)
        case .symbolic: return AnyView(symbolicKeyboard)
        default: return AnyView(Button("This keyboard is not yet implemented", action: switchKeyboard))
        }
    }
}


// MARK: - Views

private extension KeyboardView {
    
    var autocompleteToolbar: AnyView {
        AnyView(AutocompleteToolbar().frame(height: 45))
    }
    
    func alphabeticKeyboard(_ state: KeyboardShiftState) -> some View {
        AlphabeticSystemKeyboard(
            context: context,
            inputSet: .english,
            state: state,
            topmostView: autocompleteToolbar,
            customBottomRow: .demoRow(for: context))
    }
    
    var emojiKeyboard: some View {
        EmojiKeyboard()
            .padding()
            .frame(height: 600)
    }
    
    /**
     `TODO` The custom `height` is only applied to show that
     SwiftUI keyboard extensions currently don't resize when
     their content change. Remove `frame` when this is fixed.
     */
    var imageKeyboard: some View {
        ImageKeyboard()
            .padding()
            .frame(height: 600)
    }
    
    var numericKeyboard: some View {
        NumericSystemKeyboard(
            context: context,
            inputSet: .englishNumeric,
            topmostView: autocompleteToolbar,
            customBottomRow: .demoRow(for: context))
    }
    
    var symbolicKeyboard: some View {
        SymbolicSystemKeyboard(
            context: context,
            inputSet: .englishSymbolic,
            topmostView: autocompleteToolbar,
            customBottomRow: .demoRow(for: context))
    }
    
    var toastBackground: some View {
        Color.white
            .cornerRadius(3)
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 1, y: 1)
    }
}


// MARK: - Functions

private extension KeyboardView {
    
    func switchKeyboard() {
        context.actionHandler.handle(.tap, on: .keyboardType(.alphabetic(.lowercased)))
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(controller: KeyboardInputViewController())
    }
}
