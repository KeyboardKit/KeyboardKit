//
//  DemoKeyboardView.swift
//  KeyboardCustom
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This view adds a `SystemKeyboard` with some more views to a
 `VStack` and configures the keyboard slightly.
 */
struct DemoKeyboardView: View {

    unowned var controller: KeyboardInputViewController

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    var body: some View {
        VStack(spacing: 0) {
            Text("Locale: \(keyboardContext.locale.identifier)")
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(Color.primary.colorInvert())
                .cornerRadius(5)
                .padding()
                .background(Color.red)

            SystemKeyboard(
                controller: controller,
                autocompleteToolbar: .none,
                buttonContent: { $1 },
                buttonView: { $1 }
            )
            .background(Color.white)

            Color.red
        }
    }
}
