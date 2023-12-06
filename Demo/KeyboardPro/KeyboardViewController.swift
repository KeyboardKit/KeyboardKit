//
//  KeyboardViewController.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2023-02-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/**
 This keyboard demonstrates how to setup Keyboard Pro with a
 license that unlocks locales and features like autocomplete.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.

 💡 The project only links KeyboardKit Pro to the app target,
 while the base library is linked to all targets that use it.
 Since KeyboardKit Pro is a binary library, this is how it's
 supposed to be linked, since extensions can still locate it.
 */
class KeyboardViewController: KeyboardInputViewController {

    /**
     This demo will persist the current locale to be able to
     restore it the next time the keyboard is created.
     */
    deinit {
        persistedLocaleId = state.keyboardContext.locale.identifier
    }

    /**
     This function is called when the controller loads. Here,
     we make demo-specific service configurations.
     */
    override func viewDidLoad() {

        /// 💡 Add more locales to the keyboard.
        ///
        /// The demo layout provider will add a "next locale"
        /// button if you have more than one locale.
        state.keyboardContext.localePresentationLocale = .current
        // state.keyboardContext.locales = This is set to the license locales
        
        /// 💡 Setup a custom dictation key replacement.
        ///
        /// Since dictation is not available by default, the
        /// dictation button is removed if we don't set this.
        state.keyboardContext.keyboardDictationReplacement = .keyboardType(.emojis)
        
        /// 💡 Change the space long press behavior.
        ///
        /// The locale context menu will only open up if the
        /// keyboard has multiple locales.
        state.keyboardContext.spaceLongPressBehavior = .moveInputCursor
        // state.keyboardContext.spaceLongPressBehavior = .openLocaleContextMenu
        
        /// 💡 Setup audio and haptic feedback.
        ///
        /// The default haptic feedback is `.minimal`, which
        /// only has haptic feedback for long press on space.
        // state.feedbackConfiguration.audioConfiguration.delete = .custom(id: 1329)
        state.feedbackConfiguration.isHapticFeedbackEnabled = true

        /// 💡 Call super to perform the base initialization.
        super.viewDidLoad()
    }

    /**
     This function is called whenever the keyboard should be
     created or updated.
     
     Here, we register a KeyboardKit Pro license key and use
     a ``DemoKeyboardView`` as the main keyboard view.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()        
        
        /// 💡 Make the demo use a ``DemoKeyboardView``.
        ///
        /// We get an `unowned` controller reference that we
        /// can use to help us avoid memory leaks.
        setupPro(
            withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098",
            licenseConfiguration: setup   // Specified below
        ) {
            DemoKeyboardView(controller: $0)
        }
    }

    /**
     This is called by `licenseConfiguration`, to configure
     the keyboard with the registered license.
     */
    func setup(with license: License) {
        
        /// 💡 Restore the last persisted locale.
        ///
        /// The demo will fall back to English, if it hasn't
        /// persisted a locale.
        let english = KeyboardLocale.english.locale
        state.keyboardContext.locale = persistedLocale ?? english
        
        /// 💡 Setup semi-working dictation.
        ///
        /// Dictation doesn't fully work for this demo since
        /// the main app requires a code signed app group.
        state.dictationContext.setup(with: .app)
        
        /// 💡 Setup a demo-specific layout provider.
        ///
        /// The demo provider adds a "next locale" button if
        /// needed, as well as a dictation button.
        services.layoutProvider = DemoLayoutProvider(
            localizedProviders: license.localizedKeyboardLayoutProviders
        )
        
        /// 💡 Setup a theme-based style provider.
        ///
        /// Themes are powerful ways to specify styles for a
        /// keyboard. You can insert any theme below.
        services.styleProvider = (try? ThemeBasedKeyboardStyleProvider(
            theme: .standard, // .candyShop .tron
            keyboardContext: state.keyboardContext)) ?? services.styleProvider
    }


    // MARK: - Locale Persistency

    /// The defaults instance in which we store locale id
    var defaults: UserDefaults { .standard }

    /// The key used when persisting locales
    let persistedLocaleKey = "com.keyboardkit.demo.locale"

    /// The last locale used by the keyboard, if any.
    var persistedLocale: Locale? {
        guard let id = persistedLocaleId else { return nil }
        return Locale(identifier: id)
    }

    /// The last locale ID used by the keyboard, if any.
    var persistedLocaleId: String? {
        get { defaults.string(forKey: persistedLocaleKey) }
        set { defaults.set(newValue, forKey: persistedLocaleKey) }
    }
}
