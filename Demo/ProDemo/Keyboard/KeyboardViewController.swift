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
 using `SystemKeyboard` to mimic a native iOS keyboard.
 
 The demo makes demo-specific configurations in `viewDidLoad`
 and registers a custom view in `viewWillSetupKeyboard`.
 
 The keyboard registers a Pro license to unlock all keyboard
 locales, then applies either LTR or RTL locales based on if
 you are using the `Keyboard` or `KeyboardRTL` keyboard. The
 keyboard lets you change locale with a separate button, and
 remembers the current locale.
 
 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access to get
 access to features like haptic and audio feedback.
 
 Note that this demo adds KeyboardKit as a local package and
 not a remote package, as you would normally do. It makes it
 possible to change things in the library directly from this
 project instead of having to push changes to GitHub.
 */
class KeyboardViewController: KeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    /**
     The demo persists the current locale so that it can use
     it the next time the keyboard is opened.
     */
    deinit {
        lastLocaleId = keyboardContext.locale.identifier
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
        
        // Setup a demo-specific keyboard appearance
        // 💡 Play with this to change style of the keyboard
        keyboardAppearance = DemoKeyboardAppearance(context: keyboardContext)
        
        // Setup a demo-specific keyboard action handler
        // 💡 Play with this to change the keyboard behavior
        keyboardActionHandler = DemoKeyboardActionHandler(
            inputViewController: self)
        
        // Setup a demo-specific keyboard layout provider
        // 💡 Play with this to change the keyboard's layout
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            inputSetProvider: inputSetProvider,
            dictationReplacement: .keyboardType(.emojis))
        
        // Call super to perform the base initialization
        super.viewDidLoad()
    }
    
    /**
     This function is called whenever the keyboard should be
     created or updated. Here, we call `setup` or `setupPro`,
     based on if we want to use KeyboardKit Pro or not.
     
     `setupPro` will cause some configurations from above to
     be overwritten by the license configuration. To use Pro
     with custom locales, just change the locale and locales
     after calling `setupPro`.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        
        // Setup KeyboardKit Pro, using a demo-specific view
        try? setupPro(
            withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098",
            view: KeyboardView())
        
        // Restore the last used locale, if any
        // 💡 This must be done after registering Pro
        keyboardContext.locale = lastLocale ?? defaultLocale.locale
        
        // Apply the applicable locales, either LTR or RTL
        // 💡 This must be done after registering Pro
        keyboardContext.locales = applicableLocales.map { $0.locale }
    }
    
    
    // MARK: - Locale handling
    
    /**
     This demo uses LRT or RTL locales based on the keyboard.
     */
    var applicableLocales: [KeyboardLocale] {
        KeyboardLocale.allCases
            .filter { $0.isRightToLeft == isRtlKeyboard }
            .sorted(insertFirst: .english)
    }
    
    /**
     The default locale depends on if the demo is LTR or RTL.
     */
    var defaultLocale: KeyboardLocale {
        isRtlKeyboard ? .arabic : .english
    }
    
    /**
     Whether or not the demo is an RTL keyboard.
     */
    var isRtlKeyboard: Bool {
        Bundle.main.bundleIdentifier?.contains("rtl") == true
    }
    
    
    // MARK: - Locale Persistency
    
    var defaults: UserDefaults { .standard }
    
    let defaultsLocaleKey = "last-locale"
    
    /**
     The last locale used by the keyboard, if any.
     */
    var lastLocale: Locale? {
        guard let id = lastLocaleId else { return nil }
        return Locale(identifier: id)
    }
    
    /**
     The last locale ID used by the keyboard, if any.
     */
    var lastLocaleId: String? {
        get { defaults.string(forKey: defaultsLocaleKey) }
        set { defaults.set(newValue, forKey: defaultsLocaleKey) }
    }
}
