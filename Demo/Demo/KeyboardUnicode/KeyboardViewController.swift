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
 using a `SystemKeyboard` with a unicode input set.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.

 Note that this demo adds KeyboardKit as a local package, to
 make it easy to test and develop the library from this demo.
 */
class KeyboardViewController: KeyboardInputViewController {
    
    /**
     Here, we register a ``DemoInputSetProvider`` which will
     cause the keyboard to present unicode input keys.
     */
    override func viewDidLoad() {

        // Setup a demo-specific Unicode input set provider.
        inputSetProvider = DemoInputSetProvider()

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
