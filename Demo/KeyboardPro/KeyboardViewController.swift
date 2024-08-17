//
//  KeyboardViewController.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2023-02-13.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/// This keyboard demonstrates how to set up KeyboardKit Pro
/// and customize the standard configuration.
///
/// To use the keyboard, simply enable it in System Settings,
/// then switch to it with the 🌐 key when typing in any app.
///
/// This keyboard uses KeyboardKit Pro `KeyboardApp` screens
/// to open keyboard and language settings as sheet overlays.
/// This is not needed when an app can setup an App Group to
/// sync data between itself and its keyboard. In such cases,
/// settings can be managed in the main app.
///
/// The `viewDidLoad` function below has sample code to show
/// you how you can setup App Group synced keyboard settings
/// in apps that support it.
class KeyboardViewController: KeyboardInputViewController {

    /// This function is called when the controller launches.
    ///
    /// Below, we make demo-specific keyboard configurations.
    /// Play around with them to see how it affects the demo.
    override func viewDidLoad() {

        // MARK: - App Group Synced Settings

        // Call this as early as possible to set up keyboard
        // settings to sync between the app and its keyboard.
        // KeyboardSettings.setupStore(withAppGroup: "group.com.your-app-id")


        // MARK: - State

        /// 💡 Add more locales to the keyboard context. The
        /// locales are only used in the locale context menu
        /// if a user hasn't used a language settings screen.
        state.keyboardContext.localePresentationLocale = .current
        // state.keyboardContext.locales = This is set to the license locales
        
        /// 💡 Configure the space long press behavior. This
        /// can either be used to move the text input cursor
        /// or to show the locale context menu.
        state.keyboardContext.spaceLongPressBehavior = .moveInputCursor
        // state.keyboardContext.spaceLongPressBehavior = .openLocaleContextMenu
        
        /// 💡 Setup haptic and audio feedback, and register
        /// a custom audio sound for the rocket button.
        let feedback = state.feedbackContext
        feedback.audioConfiguration = .enabled
        feedback.hapticConfiguration = .enabled
        feedback.registerCustomFeedback(.haptic(.selection, for: .repeat, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketFuse, for: .press, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketLaunch, for: .release, on: .rocket))
        
        /// 💡 Disable autocorrection. We can also apply the
        /// ``autocorrectionDisabled(with:)`` view modifier.
        // state.autocompleteContext.isAutocorrectEnabled = false

        /// 💡 Call super to perform the base initialization.
        super.viewDidLoad()
    }

    /// This function is called whenever the keyboard should
    /// be created or updated.
    ///
    /// Here, we register a KeyboardKit Pro license key then
    /// use a ``DemoKeyboardView`` as the main keyboard view.
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()        
        
        /// 💡 Make the demo use a ``DemoKeyboardView``.
        ///
        /// This passes the `unowned` controller to the view,
        /// since it will be used by an input text field. If
        /// you must do this, the view must keep it `unowned`.
        ///
        /// This license key is a demo-specific key. You can
        /// use your own license key, but if you do you must
        /// also change the bundle IDs of the app & keyboard.
        setupPro(
            withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098",
            licenseConfiguration: setup,  // Specified below
            view: DemoKeyboardView.init
        )
    }

    /// This function is called when the controller switches.
    ///
    /// Here, we save the currently selected locale when the
    /// keyboard is unloaded, to automatically restore it on
    /// the next launch.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        persistLocale()
    }


    // MARK: - Setup

    /// This function is called by the `licenseConfiguration`
    /// to set up the keyboard with the registered license.
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
        
        /// 💡 Setup a demo-specific layout service.
        ///
        /// This service adds a "next locale" button if it's
        /// needed, as well as a dictation button.
        services.layoutService = DemoLayoutService(.rocket)

        /// 💡 Setup a theme-based style provider.
        ///
        /// Themes are powerful ways to specify styles for a
        /// keyboard. You can insert any theme below.
        services.styleProvider = .themed(
            with: .standard,
            keyboardContext: state.keyboardContext,
            fallback: services.styleProvider
        )
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

    /// Persist the current locale in user defaults.
    func persistLocale() {
        persistedLocaleId = state.keyboardContext.locale.identifier
    }
}
