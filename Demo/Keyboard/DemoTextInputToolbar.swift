//
//  DemoTextInputToolbar.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2023-11-27.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/// This demo-specific toolbar is used to demo how users can
/// type text within the keyboard.
struct DemoTextInputToolbar: View {

    @Binding
    var isTextInputActive: Bool

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    @FocusState
    private var isTextFieldFocused

    @State
    private var text = ""

    var body: some View {
        HStack {
            KeyboardTextField(text: $text, keyboardContext: keyboardContext) {
                $0.placeholder = "Type here..."
            }
            .focused($isTextFieldFocused)
            // {
            //     Image(systemName: "xmark.circle.fill")
            // }
            .buttonStyle(.plain)
            .padding(.top, 5)

            Button("Button.Done") {
                withAnimation {
                    isTextInputActive = false
                }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal, 3)
        .onAppear { isTextFieldFocused = true }
    }
}
