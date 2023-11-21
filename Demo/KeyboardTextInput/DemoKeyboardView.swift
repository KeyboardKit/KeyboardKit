//
//  DemoKeyboardView.swift
//  KeyboardTextInput
//
//  Created by Daniel Saidi on 2023-03-10.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/**
 This view adds a `SystemKeyboard` and two text input fields
 to a `VStack`.

 The text fields use a custom `focused` modifier that can be
 used to also automatically show a "done" button when a text
 field receives input.
 */
struct DemoKeyboardView: View {
    
    unowned var controller: KeyboardInputViewController

    @State
    private var text = ""
    
    @FocusState
    private var isFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { toolbarParams in
                    VStack {
                        toolbarParams.view
                        
                        KeyboardTextField(
                            controller.hasFullAccess ? "Search..." : "NEEDS FULL ACCESS!",
                            text: $text,
                            controller: controller
                        ) { textField in
                            textField.setLeftImage(systemName: "magnifyingglass")
                            textField.setRightImage(systemName: "magnifyingglass.circle.fill")
                        }
                        .focused($isFocused) {
                            Image(systemName: "xmark.circle.fill")
                        }
                        .tint(.secondary)
                        .padding(3)
                    }
                }
            )
        }.buttonStyle(.plain)
    }
}
