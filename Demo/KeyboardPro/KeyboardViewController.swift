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
 This controller registers a Keyboard Pro license that has a
 large set of locales and pro features, like autocomplete.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.

 `IMPORTANT!` You may have noticed how the demo project only
 links KeyboardKit Pro to the app target, while it links the
 KeyboardKit base library to every target that uses it. This
 is because KeyboardKit Pro is a binary framework, which has
 to be linked in this way.
 */
class KeyboardViewController: KeyboardInputViewController {

    
    // MARK: - View Controller Lifecycle

    /**
     The demo persists the current locale when its destroyed.
     */
    deinit {
        persistedLocaleId = keyboardContext.locale.identifier
    }

    /**
     This function is called when the controller loads. Here,
     we make demo-specific service configurations.
     */
    override func viewDidLoad() {

        /// 💡 Setup a custom dictation key replacement.
        ///
        /// Since dictation is not available by default, the
        /// dictation button is removed if we don't set this.
        keyboardContext.keyboardDictationReplacement = .keyboardType(.emojis)

        /// 💡 Change the space button long press behavior.
        ///
        /// Long pressing space will either start moving the
        /// input cursor (default), or show a locale context
        /// menu. Only change it if you think it makes sense.
        // keyboardContext.spaceLongPressBehavior = .openLocaleContextMenu

        /// 💡 Set the locale to use when displaying locales.
        ///
        /// This will for instance be used within the locale
        /// context menu.
        keyboardContext.localePresentationLocale = KeyboardLocale.english_us.locale
        
        /// 💡 Enable haptic feedback.
        ///
        /// The default haptic feedback is `.minimal`, which
        /// only has haptic feedback for long press on space.
        keyboardFeedbackSettings.enableHapticFeedback()

        /// 💡 Call super to perform the base initialization.
        super.viewDidLoad()
    }

    /**
     This function is called whenever the keyboard should be
     created or updated. Here, we call `setupPro` with a Pro
     license key, and use a ``DemoKeyboardView`` as the main
     keyboard view.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        // Setup KeyboardKit Pro, using a demo-specific view
        try? setupPro(
            withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098",
            licenseConfiguration: setup
        ) { controller in
            DemoKeyboardView(controller: controller)
        }
    }

    /**
     This function is used to configure the keyboard after a
     license is registered, but before the view is created.
     */
    func setup(with license: License) {
        setupDictation(with: license)
        setupLayout(with: license)
        setupLocale(with: license)
        setupTheme(with: license)
    }

    /**
     Setup dictation for the keyboard extension.

     > Important: Dictation doesn't fully work for this demo,
     since the main app requires a code signed app group for
     the dictated text to be available to the keyboard.
     */
    func setupDictation(with license: License) {
        dictationContext.setup(with: .app)
    }

    /**
     This function sets up an demo-specific keyboard layout.
     */
    func setupLayout(with license: License) {
        keyboardLayoutProvider = DemoLayoutProvider(
            localizedProviders: license.localizedKeyboardLayoutProviders
        )
    }

    /**
     This function restores the last persisted locale.
     */
    func setupLocale(with license: License) {
        let english = KeyboardLocale.english.locale
        let locale = persistedLocale ?? english
        keyboardContext.locale = locale
        keyboardContext.localePresentationLocale = keyboardContext.locales.first ?? english
    }

    /**
     Setup a theme from the KeyboardKit Pro theme engine.
     */
    func setupTheme(with license: License) {
        keyboardStyleProvider = (try? ThemeBasedKeyboardStyleProvider(
            theme: .standard,
            keyboardContext: keyboardContext)) ?? keyboardStyleProvider
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
