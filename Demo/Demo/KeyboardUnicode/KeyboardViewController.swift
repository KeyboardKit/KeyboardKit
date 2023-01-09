//
//  KeyboardViewController.swift
//  KeyboardUnicode
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This keyboard demonstrates how to create a keyboard that is
 using a `SystemKeyboard` to mimic a native Unicode keyboard.

 This class inherits ``DemoKeyboardViewController`` and only
 makes unicode-related changes to the standard configuration.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.

 Note that this demo adds KeyboardKit as a local package, to
 make it easy to test and develop the library from this demo.
 */
class KeyboardViewController: DemoKeyboardViewController {
    
    /**
     Here, we register demo-specific services which are then
     used by the keyboard.
     */
    override func viewDidLoad() {

        // Setup a demo-specific Unicode input set provider.
        // 💡 You can change this provider to see how the keyboard layout changes.
        inputSetProvider = DemoInputSetProvider()

        // Call super to perform the base initialization
        super.viewDidLoad()
    }
}
