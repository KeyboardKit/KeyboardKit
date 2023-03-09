//
//  KeyboardViewController.swift
//  KeyboardUnicode
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This keyboard demonstrates how to create a keyboard using a
 unicode-based input set.

 The keyboard doesn't override `viewWillSetupKeyboard` which
 makes it setup a `SystemKeyboard` which then uses the input
 set that is provided by the ``DemoInputSetProvider``.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.
 */
class KeyboardViewController: KeyboardInputViewController {

    /**
     This function is called when the controller loads. Here,
     we setup a custom ``DemoInputSetProvider``.
     */
    override func viewDidLoad() {

        /// 💡 Setup a demo-specific input set provider.
        ///
        /// You can change this provider's implementation to
        /// see how the input keys change.
        inputSetProvider = DemoInputSetProvider()

        /// 💡 Call super to perform the base initialization.
        super.viewDidLoad()
    }
}
