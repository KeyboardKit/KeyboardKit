//
//  EditScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit

/**
 This screen has a multi-line text field that can be used to
 try KeyboardKit with various keyboard appearances.
 */
struct EditScreen: View {

    let appearance: ColorScheme
    
    @State
    private var text = ""

    @FocusState
    private var isFocused: Bool

    @EnvironmentObject
    private var keyboardState: KeyboardEnabledState
    
    var body: some View {
        List {
            Section {
                TextEditor(text: $text)
                    .frame(height: 200)
                    .focused($isFocused)
                    .keyboardAppearance(appearance)
                KeyboardEnabledLabel(
                    isEnabled: keyboardState.isKeyboardActive,
                    enabledText: "Demo keyboard is selected",
                    disabledText: "Demo keyboard is not selected")
            }
        }
        .onAppear { isFocused = true }
        .navigationTitle(appearance.displayTitle)
    }
}

struct EditScreen_Previews: PreviewProvider {

    static var previews: some View {
        EditScreen(appearance: .light)
    }
}
