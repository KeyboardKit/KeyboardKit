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

    unowned var controller: KeyboardInputViewController

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    var body: some View {
        SystemKeyboard(
            controller: controller,
            buttonContent: { $1 },
            buttonView: { $1 }
        )
    }
}
