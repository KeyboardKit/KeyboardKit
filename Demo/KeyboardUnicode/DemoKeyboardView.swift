//
//  DemoKeyboardView.swift
//  KeyboardUnicode
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
 */
struct DemoKeyboardView: View {

    unowned var controller: KeyboardInputViewController

    @EnvironmentObject
    private var keyboardContext: KeyboardContext
    
    var body: some View {
        SystemKeyboard(controller: controller)
    }
}
