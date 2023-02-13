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
 This keyboard demonstrates how to create a keyboard that is
 using a `SystemKeyboard` to mimic a native Unicode keyboard.

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

        // Setup a demo-specific Unicode input set provider.
        // 💡 You can change this provider to see how the keyboard layout changes.
        inputSetProvider = DemoInputSetProvider()

        // Call super to perform the base initialization
        super.viewDidLoad()
    }

    /**
     Here, we setup KeyboardKit with a ``KeyboardView`` view
     as our main keyboard. It uses a `SystemKeyboard` to get
     a keyboard that looks like a native keyboard.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        // Setup the demo with demo-specific keyboard view.
        setup(with: DemoKeyboardView(controller: self))
    }
}
