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
 This SwiftUI-based demo keyboard demonstrates how to create
 a unicode-based keyboard.
 
 The demo makes demo-specific configurations in `viewDidLoad`
 and sets up the keyboard with a `KeyboardView`. Play around
 with the demo to see how the keyboard changes.
 
 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access if you
 want to enable haptic and audio feedback.
 
 `IMPORTANT` The `KeyboardView` is needed to ensure that the
 keyboard observes and reacts to context changes. If we just
 inject a `SystemKeyboard` in `setup`, it would become stale.
 */
class KeyboardViewController: KeyboardInputViewController {
    
    /**
     In this demo, we will only configure KeyboardKit to use
     out demo-specific input set provider.
     */
    override func viewDidLoad() {
        
        // 💡 Inject the demo-specific unicode input set.
        inputSetProvider = DemoInputSetProvider()
        
        // Call super to perform the base initialization
        super.viewDidLoad()
    }
    
    /**
     This function is called whenever the keyboard should be
     created or updated.
     
     Here, we call setup with an ordinary ``SystemKeyboard``,
     which gets a unicode-based alphabetical keyboard due to
     the input set provider that we registered earlier.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup(with: KeyboardView())
    }
}
