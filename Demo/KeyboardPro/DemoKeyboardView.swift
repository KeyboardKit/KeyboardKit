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
 This view uses a `SystemKeyboard` as the keyboard view.
 
 The setup function will actually register a `SystemKeyboard`
 by default if you don't provide a view when calling `setup`.
 
 This custom view is just here to show you how you can setup
 a custom view. Play around with the body content to see how
 the keyboard extension changes.
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
