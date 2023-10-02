//
//  KeyboardViewController.swift
//  KeyboardCustom
//
//  Created by Daniel Saidi on 2022-09-02.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This keyboard demonstrates how to create a keyboard that is
 using a `SystemKeyboard` with a custom input set and layout.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.
 */
class KeyboardViewController: KeyboardInputViewController {

    /**
     This function is called when the controller loads. Here,
     we make demo-specific service configurations.
     */
    override func viewDidLoad() {

        /// 💡 Setup a custom keyboard locale.
        ///
        /// Since the demo uses a custom layout provider, it
        /// will only affect button texts and not the layout.
        state.keyboardContext.setLocale(.english)
        
        /// 💡 Enable haptic feedback.
        ///
        /// The default haptic feedback is `.minimal`, which
        /// only has haptic feedback for long press on space.
        state.feedbackConfiguration.enableHapticFeedback()

        /// 💡 Setup a demo-specific layout provider.
        ///
        /// You can change this provider's implementation to
        /// see how the layout changes.
        services.layoutProvider = DemoLayoutProvider()

        /// 💡 Setup a demo-specific style provider.
        ///
        /// You can change this provider's implementation to
        /// see how the keyboard style changes.
        services.styleProvider = DemoStyleProvider(
            keyboardContext: state.keyboardContext)

        /// 💡 Call super to perform the base initialization.
        super.viewDidLoad()
    }

    /**
     This function is called whenever the keyboard should be
     created or updated. Here, we setup a ``DemoKeyboardView``
     as the main keyboard view.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        /// 💡 Make the demo use a ``DemoKeyboardView``.
        ///
        /// Note that we use a view builder-based `setup` to
        /// get an `unowned` controller reference that helps
        /// us avoid memory leaks caused by injecting `self`.
        setup { DemoKeyboardView(controller: $0) }
    }
}
