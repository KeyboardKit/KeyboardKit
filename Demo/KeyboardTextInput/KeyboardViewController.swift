//
//  KeyboardViewController.swift
//  KeyboardTextInput
//
//  Created by Daniel Saidi on 2023-03-10.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This keyboard demonstrates how to setup a keyboard with two
 text fields and how to manage their focused state.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.
 */
class KeyboardViewController: KeyboardInputViewController {

    /**
     This function is called whenever the keyboard should be
     created or updated. Here, we setup a `DemoKeyboardView`
     as the main keyboard view.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        /// 💡 Make the demo use a ``DemoKeyboardView``.
        ///
        /// Note that we use a view builder-based `setup` to
        /// get an `unowned` controller reference that helps
        /// us avoid memory leaks caused by injecting `self`.
        setup(with: DemoKeyboardView.init)
    }
}
