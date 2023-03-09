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
 you how you can change locale, appearance, autocomplete etc.
 Have a look at the other keyboards for more examples.

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
        /// Changing locale without using KeyboardKit Pro or
        /// a custom input set and/or layout will only cause
        /// some localized texts to change.
        keyboardContext.setLocale(.english)

        /// 💡 Add more locales to the keyboard context.
        ///
        /// You can enable this to see how the keyboard adds
        /// a locale switcher next to space and how pressing
        /// space opens up a locale menu if you also comment
        /// out that code below.
        // keyboardContext.locales = KeyboardLocale.allCases.map { $0.locale }

        /// 💡 Setup a custom dictation key replacement.
        ///
        /// Since dictation is not available by default, you
        /// can use this to replace the dictation key if you
        /// want to. If you don't do this, the key will just
        /// be removed.
        keyboardContext.keyboardDictationReplacement = .keyboardType(.emojis)

        /// 💡 Make long pressing space open a locale menu.
        ///
        /// You can enable this to see how the keyboard will
        /// change from moving the cursor and instead open a
        /// locale menu when space is long pressed.
        // keyboardContext.spaceLongPressBehavior = .openLocaleContextMenu

        /// 💡 Setup a fake autocomplete provider.
        ///
        /// You can change this provider's implementation to
        /// see how the autocomplete changes. Have a look at
        /// the KeyboardPro demos to see how a real provider
        /// behaves as you type or move the cursor.
        autocompleteProvider = FakeAutocompleteProvider()

        /// 💡 Setup a demo-specific keyboard appearance.
        ///
        /// You can change this appearance implementation to
        /// see how the keyboard style changes.
        keyboardAppearance = DemoKeyboardAppearance(
            keyboardContext: keyboardContext)

        /// 💡 Setup a demo-specific keyboard action handler.
        ///
        /// You can change the handler implementation to see
        /// how the keyboard behavior changes as you type.
        keyboardActionHandler = DemoKeyboardActionHandler(
            inputViewController: self)

        /// 💡 Setup a demo-specific layout provider.
        ///
        /// You can change this provider's implementation to
        /// see how the layout changes.
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider)

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
