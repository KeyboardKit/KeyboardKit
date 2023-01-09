//
//  DemoKeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This base keyboard view controller is inherited by all demo
 ``KeyboardViewController`` classes in this project.

 The class sets up a foundation for a KeyboardKit-based demo
 keyboard, with demo-specific configurations, then sets up a
 ``KeyboardView`` that has a `SystemKeyboard`-based keyboard.
 You can change all these configurations at any time, to see
 how the keyboard changes.
 */
class DemoKeyboardViewController: KeyboardInputViewController {

    /**
     Here, we register demo-specific services which are then
     used by the keyboard.
     */
    override func viewDidLoad() {

        // Set a custom keyboard locale
        // 💡 Changing locale without KeyboardKit Pro or custom input sets will only change some button texts.
        keyboardContext.setLocale(.english)

        // Set a custom dictation key replacement.
        // 💡 This will replace the dictation button on keyboards that need it.
        keyboardContext.keyboardDictationReplacement = .keyboardType(.emojis)

        // Setup a fake, demo-specific autocomplete provider.
        // 💡 You can change this provider to see how the autocomplete changes.
        autocompleteProvider = FakeAutocompleteProvider()

        // Setup an custom input set provider.
        // 💡 Have a look at the other demo projects, where this is done.
        // inputSetProvider = ...

        // Setup a demo-specific keyboard appearance.
        // 💡 You can change this appearance to see how the keyboard style changes.
        keyboardAppearance = DemoKeyboardAppearance(
            keyboardContext: keyboardContext)

        // Setup a demo-specific keyboard action handler.
        // 💡 You can change this handler to see how the keyboard behavior changes.
        keyboardActionHandler = DemoKeyboardActionHandler(
            inputViewController: self)

        // Setup a demo-specific keyboard layout provider.
        // 💡 You can change this provider to see how the keyboard layout changes.
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider)

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
        setup(with: KeyboardView())
    }
}
