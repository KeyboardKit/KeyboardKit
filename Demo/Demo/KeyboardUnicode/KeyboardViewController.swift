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
 using `SystemKeyboard` to mimic a native iOS keyboard.
 
 The demo makes demo-specific configurations in `viewDidLoad`
 and registers a custom view in `viewWillSetupKeyboard`.
 
 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic and audio feedback.
 
 Note that this demo adds KeyboardKit as a local package and
 not a remote package, as you would normally do. It makes it
 possible to change things in the library directly from this
 project instead of having to push changes to GitHub.
 */
class KeyboardViewController: KeyboardInputViewController {
    
    /**
     In this demo, we will only configure KeyboardKit to use
     a demo-specific, unicode-based input set provider.
     */
    override func viewDidLoad() {
        
        // Inject a demo-specific unicode input set provider
        // 💡 Play with this to change the keyboard's layout
        inputSetProvider = DemoInputSetProvider()
        
        // Call super to perform the base initialization
        super.viewDidLoad()
    }
    
    /**
     This function is called whenever the keyboard should be
     created or updated.
     
     Here, we call setup with a demo-specific view that uses
     ``SystemKeyboard`` to mimic a native iOS keyboard.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        
        // Setup a demo-specific keyboard view
        setup(with: KeyboardView())
    }
}
