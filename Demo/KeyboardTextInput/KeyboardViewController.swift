//
//  KeyboardViewController.swift
//  KeyboardTextInput
//
//  Created by Daniel Saidi on 2023-03-10.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/**
 This keyboard demonstrates how to setup a keyboard with two
 text fields and how to manage their focused state.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.

 💡 The project only links KeyboardKit Pro to the app target,
 while the base library is linked to all targets that use it.
 Since KeyboardKit Pro is a binary library, this is how it's
 supposed to be linked, since extensions can still locate it.
 */
class KeyboardViewController: KeyboardInputViewController {

    /**
     This function is called whenever the keyboard should be
     created or updated.
     
     Here we setup a `DemoKeyboardView` as the keyboard view.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        /// 💡 Make the demo use a ``DemoKeyboardView``.
        ///
        /// We get an `unowned` controller reference that we
        /// can use to help us avoid memory leaks.
        setupPro(
            withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098"
        ) {
            DemoKeyboardView(controller: $0)
        }
    }
}
