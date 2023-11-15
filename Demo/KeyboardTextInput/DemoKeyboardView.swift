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

    @State
    private var text = ""

    @FocusState
    private var isFocused: Bool

    unowned var controller: KeyboardInputViewController

    var body: some View {
        VStack(spacing: 0) {
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { params in
                    VStack {
                        params.view
                        KeyboardTextField(
                            controller.hasFullAccess ? "Search..." : "NEEDS FULL ACCESS!",
                            text: $text,
                            controller: controller
                        )
                        .focused($isFocused, doneButton: doneButton)
                        .padding(3)
                    }
                }
            )
        }.buttonStyle(.plain)
    }

    func doneButton() -> some View {
        Image(systemName: "x.circle.fill")
    }
}
