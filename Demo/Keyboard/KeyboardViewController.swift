//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit
import KeyboardKitPro
import SwiftUI
import Combine

/**
 This SwiftUI-based demo keyboard demonstrates how to create
 a keyboard extension using `KeyboardKit` and `SwiftUI`.
 
 This demo registers demo-specific services in `viewDidLoad`
 and sets up KeyboardKit with a `KeyboardView` that uses the
 services in `viewWillSetupKeyboard`. Feel free to play with
 these to see how the keyboard behavior changes.
 
 The demo can be configured with and without KeyboardKit Pro
 support. Without Pro, the demo only supports English locale
 and uses a fake autocomplete engine. With Pro, the demo has
 support for all locales and uses a real autocomplete engine.
 Just comment out `setupPro` to disable Pro support.
 
 To use this keyboard, you must enable it in system settings
 ("Settings/General/Keyboards"). It needs full access if you
 want to enable haptic and audio feedback.

 `IMPORTANT` The `KeyboardView` has many environment objects
 that make it automatically update when these objects change.
 The `KeyboardViewController` will not trigger these changes
 automatically, so make sure to define your own app-specific
 view that can setup these bindings.
 */
class KeyboardViewController: KeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    /**
     The demo persists the current locale so that it can use
     it the next time the demo keyboard is opened.
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
        
        // Setup a demo-specific autocomplete provider
        // 💡 This is overwritten if Pro is registered below
        autocompleteProvider = FakeAutocompleteProvider()
        
        // Setup a callout action provider
        // 💡 This is overwritten if Pro is registered below
        calloutActionProvider = StandardCalloutActionProvider(
            context: keyboardContext,
            providers: [try? EnglishCalloutActionProvider()].compactMap { $0 })
        
        // Setup a standard input set provider
        // 💡 This is overwritten if Pro is registered below
        inputSetProvider = StandardInputSetProvider(
            context: keyboardContext,
            providers: [EnglishInputSetProvider()])
        
        // Setup a demo-specific keyboard appearance
        // 💡 Adjust the DemoAppearance to see what happens
        keyboardAppearance = DemoAppearance(context: keyboardContext)
        
        // Setup the demo to explicitly use English locale
        // 💡 This is overwritten if Pro is registered below
        keyboardContext.locale = KeyboardLocale.english.locale
        
        // Setup the locales that the keyboard supports
        // 💡 This is overwritten if Pro is registered below
        keyboardContext.locales = [KeyboardLocale.english.locale]
        
        // Setup a custom, demo-specific action handler
        // 💡 You can create your own custom action handlers
        keyboardActionHandler = DemoKeyboardActionHandler(
            inputViewController: self)
        
        // Setup a demo-specific keyboard layout provider
        // 💡 A layout provider defines the keyboard layout
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            inputSetProvider: inputSetProvider,
            dictationReplacement: .keyboardType(.emojis))
        
        // Perform the base initialization
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
        
        // 💡 Make sure that only one setup call is enabled.
        // setup(with: KeyboardView())
        try? setupPro(
            withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098",
            view: KeyboardView())
        
        // 💡 To change locales when using Pro, do so here:
        keyboardContext.locale = lastLocale ?? KeyboardLocale.english.locale
        // keyboardContext.locale = KeyboardLocale.english.locale
        // keyboardContext.locales = [KeyboardLocale.english.locale]
    }
    
    
    // MARK: - Autocomplete
    
    /**
     Override this function to add custom autocomplete logic
     to your keyboard extension.
     */
    override func performAutocomplete() {
        super.performAutocomplete()
    }
    
    /**
     Override this function to add custom autocomplete reset
     logic to your keyboard extension.
     */
    override func resetAutocomplete() {
        super.resetAutocomplete()
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
