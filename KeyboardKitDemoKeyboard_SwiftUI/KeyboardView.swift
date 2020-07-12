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
 */
struct KeyboardView: View {
    
    init(controller: KeyboardInputViewController) {
        self.controller = controller
    }
    
    private let controller: KeyboardInputViewController
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var context: ObservableKeyboardContext
    
    var body: some View {
        ZStack {
        
            keyboardView
            text
        }
    }
    
    var text: Text {
        let a = context.textDocumentProxy.keyboardAppearance == .default
        let b = context.textDocumentProxy.keyboardAppearance == .light
        let c = context.textDocumentProxy.keyboardAppearance == .dark
        let d = context.traitCollection.userInterfaceStyle == .light
        let e = context.controller.traitCollection.userInterfaceStyle == .light
        let f = colorScheme == .light
        let str = "\(a) \(b) \(c) \(d) \(e) \(f)"
        return Text(str)
    }
}

private extension KeyboardView {
    
    func alphabeticKeyboard(_ state: KeyboardShiftState) -> some View {
        AlphabeticSystemKeyboard(inputSet: .english, state: state, topmostView: AnyView(AutocompleteToolbar()))
    }
    
    func numericKeyboard() -> some View {
        NumericSystemKeyboard(inputSet: .englishNumeric, topmostView: AnyView(AutocompleteToolbar()))
    }
    
    func symbolicKeyboard() -> some View {
        SymbolicSystemKeyboard(inputSet: .englishSymbolic, topmostView: AnyView(AutocompleteToolbar()))
    }
    
    /**
     `TODO` After upgrading to Xcode 14 and Swift 5.3, we'll
     move this into `body`, since switches will be supported.
     */
    var keyboardView: AnyView {
        switch context.keyboardType {
        case .alphabetic(let state): return AnyView(alphabeticKeyboard(state))
        case .numeric: return AnyView(numericKeyboard())
        case .symbolic: return AnyView(symbolicKeyboard())
        default: return AnyView(Button("This keyboard is not yet implemented", action: switchKeyboard))
        }
    }
    
    func switchKeyboard() {
        context.actionHandler.handle(.tap, on: .keyboardType(.alphabetic(.lowercased)))
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(controller: KeyboardInputViewController())
    }
}
