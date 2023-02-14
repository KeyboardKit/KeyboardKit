//
//  ProDemoViewController.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2023-02-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/**
 This controller is shared between the two Pro-specific demo
 keyboards and registers a Pro license with multiple locales.

 The keyboard registers a Pro license to unlock all keyboard
 locales, then applies either LTR or RTL locales based on if
 you are using `KeyboardPro` or `KeyboardProRTL`. If the RTL
 locale set is applied, we also flip the interface direction
 in the demo app, so that the entire app becomes RTL.

 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.

 IMPORTANT: You may notice how the demo adds KeyboardKit Pro
 to the app target instead of the keyboard extensions, while
 the regular KeyboardKit is added to each keyboard extension.
 This is how KeyboardKit Pro must be linked, since this is a
 binary framework.
 */
class ProDemoViewController: KeyboardInputViewController {

    // MARK: - View Controller Lifecycle

    /**
     The demo persists the current locale so that it can use
     it the next time the keyboard is opened.
     */
    deinit {
        persistedLocaleId = keyboardContext.locale.identifier
    }

    /**
     Here, we register demo-specific services which are then
     used by the keyboard.
     */
    override func viewDidLoad() {

        // Setup a custom dictation key replacement.
        // 💡 This will replace the dictation button on keyboards that need it.
        keyboardContext.keyboardDictationReplacement = .keyboardType(.emojis)

        // Call super to perform the base initialization
        super.viewDidLoad()
    }

    /**
     This function is called whenever the keyboard should be
     created or updated. Here, we call `setupPro` with a Pro
     license key, since this keyboard uses KeyboardKit Pro.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        // Setup KeyboardKit Pro, using a demo-specific view
        try? setupPro(
            withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098",
            view: DemoKeyboardView(controller: self),
            licenseConfiguration: setupKeyboardWithLicense)
    }

    /**
     This function is used to configure the keyboard after a
     license is registered, but before the view is created.
     */
    func setupKeyboardWithLicense(_ license: License) {

        // Restore the last used locale, if any
        // 💡 This must be done after registering Pro
        keyboardContext.locale = persistedLocale ?? defaultLocale.locale

        // Apply the applicable locales, either LTR or RTL
        // 💡 This must be done after registering Pro
        keyboardContext.locales = demoLocales.map { $0.locale }

        // Setup a demo-specific keyboard layout provider
        // 💡 Play with this to change the keyboard's layout
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            license: license,
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider)
    }


    // MARK: - Locales

    /**
     The default locale depends on if the demo is LTR or RTL.
     */
    var defaultLocale: KeyboardLocale {
        isRtlKeyboard ? .arabic : .english
    }

    /**
     This demo uses LRT or RTL locales based on the keyboard.
     */
    var demoLocales: [KeyboardLocale] {
        KeyboardLocale.allCases
            .filter { $0.isRightToLeft == isRtlKeyboard }
            .sorted(insertFirst: .english)
    }

    /**
     Whether or not the demo is an RTL keyboard.
     */
    var isRtlKeyboard: Bool {
        Bundle.main.bundleIdentifier?.contains("rtl") == true
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
