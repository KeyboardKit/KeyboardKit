//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This keyboard demonstrates how to create a keyboard that is
 using a `SystemKeyboard` to mimic a native English keyboard.

 This keyboard also uses a couple of custom services to show
 you how you can change locale, style, autocomplete, etc.

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
        /// Since the demo doesn't use KeyboardKit Pro, this
        /// will only affect button texts and not the layout.
        keyboardContext.setLocale(.english)

        /// 💡 Add more locales to the keyboard.
        ///
        /// You can add a locale switch key using the custom
        /// layout provider in this demo, or just enable the
        /// space long press behavior below.
        // keyboardContext.locales = KeyboardLocale.allCases.map { $0.locale }
        
        /// 💡 Change the space long press behavior.
        ///
        /// The locale context menu will only open up if the
        /// keyboard has multiple locales.
        // keyboardContext.spaceLongPressBehavior = .openLocaleContextMenu

        /// 💡 Setup a custom dictation key replacement.
        ///
        /// Since dictation is not available by default, the
        /// dictation button is removed if we don't set this.
        keyboardContext.keyboardDictationReplacement = .keyboardType(.emojis)
        
        /// 💡 Enable haptic feedback.
        ///
        /// The default haptic feedback is `.minimal`, which
        /// only has haptic feedback for long press on space.
        keyboardFeedbackSettings.enableHapticFeedback()
        
        /// 💡 Setup a fake autocomplete provider.
        ///
        /// Change the provider implementation to see how it
        /// affects the autocomplete suggestion. Try the Pro
        /// demo to see how the pro provider behaves.
        autocompleteProvider = FakeAutocompleteProvider()

        /// 💡 Setup a demo-specific keyboard action handler.
        ///
        /// You can change the handler implementation to see
        /// how the keyboard behavior changes as you type.
        keyboardActionHandler = DemoActionHandler(
            inputViewController: self)

        /// 💡 Setup a demo-specific layout provider.
        ///
        /// You can change this provider's implementation to
        /// see how the layout changes.
        keyboardLayoutProvider = DemoLayoutProvider()
        
        /// 💡 Setup a demo-specific style provider.
        ///
        /// You can change this provider's implementation to
        /// see how the keyboard style changes.
        keyboardStyleProvider = DemoStyleProvider(
            keyboardContext: keyboardContext)

        /// 💡 Call super to perform the base initialization.
        super.viewDidLoad()
    }

    /**
     This function is called whenever the keyboard should be
     created or updated. Here, we setup a system keyboard as
     the main keyboard view.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        /// 💡 Make the demo use a ``SystemKeyboard``.
        ///
        /// This is actually not needed. The controller will
        /// by default setup a `SystemKeyboard`, so you only
        /// have to override this function to setup a custom
        /// view, which we do in `KeyboardCustom`.
        setup { SystemKeyboard(controller: $0) }
    }
}
