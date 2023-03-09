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
 This view sets up a `SystemKeyboard` as a keyboard view and
 adds an `AutocompleteToolbar` above it.

 The keyboard will look and behave as is defined by services
 and configurations in the ``ProDemoViewController``.

 While the `SystemKeyboard` is very flexible, it can also be
 easily created by just providing it with a controller, like
 we do here. The standard configuration adds an autocomplete
 toolbar topmost and uses an emoji keyboard whenever needed.
 */
struct DemoKeyboardView: View {

    unowned var controller: KeyboardInputViewController

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    var body: some View {
        SystemKeyboard(controller: controller)
    }
}
