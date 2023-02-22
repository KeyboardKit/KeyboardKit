//
//  DemoKeyboardView.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This view wraps a `SystemKeyboard`, which aims to mimic the
 native iOS keyboard as closely as possible.

 While the `SystemKeyboard` is very flexible, it can also be
 easily created by just providing it with a controller, like
 we do here. This configuration adds an autocomplete toolbar
 above the keyboard and replaces the system keyboard with an
 emoji keyboard whenever needed.

 This view adds some extra views around the keyboard to show
 how easy it is to use native SwiftUI with KeyboardKit.
 */
struct DemoKeyboardView: View {

    unowned var controller: KeyboardInputViewController

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    var body: some View {
        VStack {
            Text("Locale: \(keyboardContext.locale.identifier)")
                .frame(maxWidth: .infinity)
                .background(Color.primary.colorInvert())
                .cornerRadius(5)
                .padding()
                .background(Color.red)
            SystemKeyboard(
                controller: controller,
                autocompleteToolbar: .none
            )
            Color.red
        }
    }
}
