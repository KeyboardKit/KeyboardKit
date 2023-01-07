//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/**
 This keyboard demonstrates how to create a keyboard that is
 using a `SystemKeyboard` to mimic a native keyboard that is
 using KeyboardKit Pro to unlock several localized keyboards.
 
 The keyboard makes demo-specific configurations and sets up
 the keyboard with a ``KeyboardView``. You can change all of
 these configurations to see how the keyboard changes.
 
 The keyboard registers a Pro license to unlock all keyboard
 locales, then applies either LTR or RTL locales based on if
 you are using the `Keyboard` or `KeyboardRTL` keyboard. The
 keyboard lets you change locale with a separate button that
 is inserted by the ``DemoKeyboardLayoutProvider``.
 
 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic feedback.
 
 Note how this demo adds KeyboardKit Pro to the main app and
 not its keyboard extensions. This is how KeyboardKit Pro is
 to be added, since it's a binary framework. KeyboardKit has
 to be added to all targets that use it, but KeyboardKit Pro
 only has to be added to the main app.
 */
class KeyboardViewController: KeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    /**
     The demo persists the current locale so that it can use
     it the next time the keyboard is opened.
     */
    deinit {
        persistedLocaleId = keyboardContext.locale.identifier
    }
    
    /**
     You can configure KeyboardKit keyboards in many ways. A
     few configurations below are already done by default in
     the library and are just here to show you how it's done
     and to explain what the various services do.
     
     Some configurations will be overridden by registering a
     Pro license in `viewWillSetupKeyboard`.
     */
    override func viewDidLoad() {

        // This is how you would change the keyboard locale
        // 💡 This is overwritten as Pro is registered below
        keyboardContext.locale = KeyboardLocale.english.locale
        
        // This is how you would change the keyboard locales
        // 💡 This is overwritten as Pro is registered below
        keyboardContext.locales = [KeyboardLocale.english.locale]

        // Set a custom dictation key replacement
        // 💡 This will replace the dictation button on keyboards that have one
        keyboardContext.keyboardDictationReplacement = .keyboardType(.emojis)
        
        // Setup a demo-specific keyboard appearance
        // 💡 Play with this to change style of the keyboard
        keyboardAppearance = DemoKeyboardAppearance(context: keyboardContext)
        
        // Setup a demo-specific keyboard action handler
        // 💡 Play with this to change the keyboard behavior
        keyboardActionHandler = DemoKeyboardActionHandler(
            inputViewController: self)
        
        // Call super to perform the base initialization
        super.viewDidLoad()
    }
    
    /**
     This function is called whenever the keyboard should be
     created or updated. Here, we call `setupPro`, since the
     keyboard uses KeyboardKit Pro.
     
     `setupPro` will cause some configurations from above to
     be overwritten, such as registering the license locales.
     To customize the keyboard after registering the license,
     you can use the `setupPro` license configuration block.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        
        // Setup KeyboardKit Pro, using a demo-specific view
        try? setupPro(
            withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098",
            view: KeyboardView(),
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
    
    
    // MARK: - Locale handling
    
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
    
    var defaults: UserDefaults { .standard }
    
    let persistedLocaleKey = "com.keyboardkit.demo.locale"
    
    /**
     The last locale used by the keyboard, if any.
     */
    var persistedLocale: Locale? {
        guard let id = persistedLocaleId else { return nil }
        return Locale(identifier: id)
    }
    
    /**
     The last locale ID used by the keyboard, if any.
     */
    var persistedLocaleId: String? {
        get { defaults.string(forKey: persistedLocaleKey) }
        set { defaults.set(newValue, forKey: persistedLocaleKey) }
    }
}
