//
//  KeyboardViewController.swift
//  KeyboardCustom
//
//  Created by Daniel Saidi on 2022-09-02.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This keyboard demonstrates how to create a keyboard that is
 using a `SystemKeyboard` with a custom input set and layout.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.

 Note that this demo adds KeyboardKit as a local package, to
 make it easy to test and develop the library from this demo.
 */
class KeyboardViewController: KeyboardInputViewController {

    /**
     Here, we register demo-specific services which are then
     used by the keyboard.
     */
    override func viewDidLoad() {

        // Setup a demo-specific input set provider.
        inputSetProvider = DemoInputSetProvider()

        // Setup a demo-specific keyboard layout provider.
        keyboardLayoutProvider = DemoLayoutProvider(
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider
        )

        // setup a demo-specific keyboard appearance.
        keyboardAppearance = DemoKeyboardAppearance(
            keyboardContext: keyboardContext
        )

        // Call super to perform the base initialization
        super.viewDidLoad()
    }

    /**
     Here, we setup the controller to use ``DemoKeyboardView``
     as the main keyboard view.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        // Setup the demo with demo-specific keyboard view.
        setup(with: DemoKeyboardView(controller: self))
    }
}
