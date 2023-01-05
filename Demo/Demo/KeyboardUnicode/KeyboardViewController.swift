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
 using `SystemKeyboard` to mimic a native Unicode keyboard.

 The keyboard makes demo-specific configurations and sets up
 the keyboard with a ``KeyboardView``. You can change all of
 these configurations to see how the keyboard changes.
 
 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic and audio feedback.

 Note that this demo adds KeyboardKit as a local package and
 not as a remote package, as you would normally add it. This
 is done to make it possible to change the package from this
 project and make it easier to quickly try out new things.
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

        // Setup a demo-specific keyboard appearance.
        // 💡 You can change this appearance to see how the keyboard style changes.
        keyboardAppearance = DemoKeyboardAppearance(
            keyboardContext: keyboardContext)
        
        // Call super to perform the base initialization
        super.viewDidLoad()
    }
    
    /**
     This function is called whenever the keyboard should be
     created or updated.

     Here, we use the ``KeyboardView`` to setup the keyboard.
     This will create a `SystemKeyboard`-based keyboard that
     looks like a native keyboard.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        
        // Setup the demo with demo-specific keyboard view.
        setup(with: KeyboardView())
    }
}
