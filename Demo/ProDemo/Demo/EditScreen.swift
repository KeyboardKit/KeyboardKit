//
//  EditScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKitPro

/**
 This screen has a multi-line text field that can be used to
 try KeyboardKit with various keyboard appearances.
 */
struct EditScreen: View {
    
    let appearance: UIKeyboardAppearance
    
    @State
    private var text = ""
    
    @EnvironmentObject
    private var keyboardState: KeyboardEnabledState
    
    var body: some View {
        List {
            Section {
                MultilineTextField(text: $text, appearance: appearance)
                    .frame(height: 200)
                EnabledListItem(
                    isEnabled: keyboardState.isKeyboardCurrentlyActive,
                    enabledText: "Demo keyboard is selected",
                    disabledText: "Demo keyboard is not selected")
            }
        }.navigationTitle(title)
    }
}

private extension EditScreen {
    
    var title: String {
        appearance == .dark ? "Dark text field" : "Regular text field"
    }
}

struct EditScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditScreen(appearance: .default)
    }
}
