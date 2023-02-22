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

 The keyboard will look and behave as is defined by services
 and configurations in the ``KeyboardViewController``.

 While the `SystemKeyboard` is very flexible, it can also be
 easily created by just providing it with a controller, like
 we do here. The standard configuration adds an autocomplete
 toolbar topmost and uses an emoji keyboard whenever needed.

 Have a look at the custom keyboard demo to see how easy you
 can add custom views around the system keyboard. 
 */
struct DemoKeyboardView: View {

    unowned var controller: KeyboardInputViewController

    var body: some View {
        SystemKeyboard(controller: controller)
    }
}
