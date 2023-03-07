//
//  KeyboardViewController.swift
//  KeyboardCustom
//
//  Created by Daniel Saidi on 2022-09-02.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This keyboard demonstrates how to create a keyboard that is
 using a `SystemKeyboard` with a custom input set and layout.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.
 */
class KeyboardViewController: KeyboardInputViewController {

    /**
     This function is called when the controller loads. Here,
     we make demo-specific service configurations.
     */
    override func viewDidLoad() {

        /// 💡 Setup a demo-specific input set provider.
        ///
        /// This will affect the input keys for the keyboard.
        inputSetProvider = DemoInputSetProvider()

        /// 💡 Setup a demo-specific layout provider.
        ///
        /// This will affect the keyboard layout, sizes etc.
        keyboardLayoutProvider = DemoLayoutProvider(
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider)

        /// 💡 Setup a demo-specific keyboard appearance.
        ///
        /// You can change this appearance implementation to
        /// see how the keyboard style changes.
        keyboardAppearance = DemoKeyboardAppearance(
            keyboardContext: keyboardContext)

        /// 💡 Call super to perform the base initialization.
        super.viewDidLoad()
    }

    /**
     This function is called whenever the keyboard should be
     created or updated. Here, we setup a ``DemoKeyboardView``
     as the main keyboard view.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        /// 💡 Make the demo use a ``DemoKeyboardView``.
        ///
        /// This is KeyboardKit can be configured to use any
        /// custom view. Note that we use a controller-based
        /// `setup` function to avoid potential memory leaks
        /// that can be caused by injecting `self`.
        setup(with: DemoKeyboardView(controller: self))
    }
}
