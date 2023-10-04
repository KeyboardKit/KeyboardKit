//
//  DemoKeyboardView.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/**
 This view sets up a `SystemKeyboard` as a keyboard view. It
 is just to show you how you can use custom views.
 */
struct DemoKeyboardView: View {

    var state: Keyboard.KeyboardState
    var services: Keyboard.KeyboardServices

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    var body: some View {
        SystemKeyboard(
            state: state,
            services: services,
            buttonContent: { $0.view },
            buttonView: { $0.view },
            emojiKeyboard: { _ in EmojiKeyboard(
                state: state,
                services: services)
            },
            toolbar: { $0.view }
        )
    }
}
