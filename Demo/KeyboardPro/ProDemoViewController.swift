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
 keyboards and will register a Pro license with many locales.

 The keyboard registers a Pro license to unlock all keyboard
 locales, then applies either LTR or RTL locales based on if
 you are using `KeyboardPro` or `KeyboardProRTL`. A keyboard
 can also register RTL in its `Info.plist` file, by toggling
 the `PrefersRightToLeft` extension attribute to `YES`.

 `IMPORTANT!` You may have noticed how the demo project only
 links KeyboardKit Pro to the app target, while it links the
 KeyboardKit base library to every target that uses it. This
 is because KeyboardKit Pro is a binary framework, which has
 to be linked in this way.
 */
class ProDemoViewController: KeyboardInputViewController {

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

        /// 💡 Enable the new autocomplete provider.
        ///
        /// This feature is experimental and must be enabled
        /// with the shared `FeatureToggle`. If the provider
        /// works great, the next minor version will replace
        /// the old provider with this new one.
        FeatureToggle.shared.toggleFeature(.newAutocompleteEngine, .on)

        /// 💡 Setup a custom dictation key replacement.
        ///
        /// Since dictation is not available by default, you
        /// can use this to replace the dictation key if you
        /// want to. If you don't do this, the key will just
        /// be removed.
        keyboardContext.keyboardDictationReplacement = .keyboardType(.emojis)

        /// 💡 Change the space button long press behavior.
        ///
        /// Long pressing the space key can either start the
        /// input cursor movement or show a context menu for
        /// switching locale.
        ///
        /// IMPORTANT! Only change this if you think that it
        /// really makes sense. Long pressing space to start
        /// moving the input cursor is the standard behavior
        /// and will probably be expected by your users.
        keyboardContext.spaceLongPressBehavior = .openLocaleContextMenu

        /// 💡 Make locales use their English names when the
        /// locale context menu is presented.
        ///
        /// The locale context menu is shown by pressing the
        /// locale switcher in this demo, or space when it's
        /// configured with `.openLocaleContextMenu` above.
        keyboardContext.localePresentationLocale = KeyboardLocale.english_us.locale

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
            view: { controller in DemoKeyboardView(controller: controller) },
            licenseConfiguration: setupKeyboardWithLicense)
    }

    /**
     This function is used to configure the keyboard after a
     license is registered, but before the view is created.
     */
    func setupKeyboardWithLicense(_ license: License) {

        // The locale to use, either persisted or default
        let locale = persistedLocale ?? .defaultDemoLocale

        // Restore the last used locale, if any
        // 💡 This must be done after registering Pro
        keyboardContext.locale = locale

        // Apply the applicable locales, either LTR or RTL
        // 💡 This must be done after registering Pro
        keyboardContext.locales = .demoLocales
            .sorted(in: locale, insertFirst: locale)
            .filter { license.locales.map { $0.locale }.contains($0) }

        // Setup a theme-based appearance
        // 💡 You can use built-in themes or create your own
        // keyboardAppearance = (try? KeyboardThemeAppearance(
        //     theme: .cottonCandy,
        //     // theme: .neonNights,
        //     // theme: .tron,
        //     keyboardContext: keyboardContext)) ?? keyboardAppearance

        // Setup a demo-specific keyboard layout provider
        // 💡 Play with this to change the keyboard's layout
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            license: license,
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider
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
}
