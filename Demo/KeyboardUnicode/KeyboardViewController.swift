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

 This keyboard does not override `viewWillSetupKeyboard` and
 therefore uses a standard `SystemKeyboard`. It however uses
 ``DemoLayoutProvider`` to get a custom keyboard layout.

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
        
        /// 💡 Setup a demo-specific layout provider.
        ///
        /// You can change this provider's implementation to
        /// see how the layout changes.
        keyboardLayoutProvider = DemoLayoutProvider()

        /// 💡 Call super to perform the base initialization.
        super.viewDidLoad()
    }
}
