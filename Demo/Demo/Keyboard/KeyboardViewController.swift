//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
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
     In this demo, we will configure KeyboardKit to use some
     demo-specific services.
     */
    override func viewDidLoad() {
        
        // Setup a fake, demo-specific autocomplete provider
        autocompleteProvider = FakeAutocompleteProvider()
        
        // Setup a demo-specific keyboard appearance
        // 💡 Play with this to change style of the keyboard
        keyboardAppearance = DemoKeyboardAppearance(context: keyboardContext)
        
        // Setup a demo-specific keyboard action handler
        // 💡 Play with this to change the keyboard behavior
        keyboardActionHandler = DemoKeyboardActionHandler(
            inputViewController: self)
        
        // Setup a demo-specific keyboard layout provider
        // 💡 Play with this to change the keyboard's layout
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            inputSetProvider: inputSetProvider,
            dictationReplacement: nil)
        
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
