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
     You can configure your keyboard extension in many, many
     ways. Some configurations below are already done in the
     library and just here to show you how it's done and for
     explaining what the various services do.
     
     Some configurations will be overridden by registering a
     Pro license in `viewWillSetupKeyboard`. Just move these
     configurations to after setting up pro.
     */
    override func viewDidLoad() {
        
        // Setup a demo-specific autocomplete provider
        // 💡 This is overwritten if Pro is registered below
        autocompleteProvider = FakeAutocompleteProvider()
        
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
        
        // Setup a standard input set provider
        // 💡 This is overwritten if Pro is registered below
        keyboardInputSetProvider = StandardKeyboardInputSetProvider(
            context: keyboardContext,
            providers: [EnglishKeyboardInputSetProvider()])
        
        // Setup a demo-specific keyboard layout provider
        // 💡 A layout provider defines the keyboard layout
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            inputSetProvider: keyboardInputSetProvider,
            dictationReplacement: .keyboardType(.emojis))
        
        // Setup a secondary callout action provider
        // 💡 This is overwritten if Pro is registered below
        keyboardSecondaryCalloutActionProvider = StandardSecondaryCalloutActionProvider(
            context: keyboardContext,
            providers: [try? EnglishSecondaryCalloutActionProvider()].compactMap { $0 })
        
        // Perform the base initialization
        super.viewDidLoad()
    }
    
    /**
     This function is called whenever the keyboard should be
     created or updated. Here, we call `setup` or `setupPro`,
     depending on if we want to use KeyboardKit Pro or not.
     
     If you call `setupPro`, some of the configurations will
     be reset, since a license specifies things like default
     locale, unlocks autocomplete etc. If you want to change
     the locale and locales in the demo, do so after calling
     `setupPro`.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        
        // 💡 Make sure that only one setup call is enabled.
        // setup(with: keyboardView)
        try? setupPro(withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098", view: keyboardView)
        
        // 💡 To change locales when using Pro, do so here:
        // keyboardContext.locale = KeyboardLocale.english.locale
        // keyboardContext.locales = [KeyboardLocale.english.locale]
    }
    
    
    // MARK: - Properties
        
    private var keyboardView: some View {
        KeyboardView(
            actionHandler: keyboardActionHandler,
            appearance: keyboardAppearance,
            layoutProvider: keyboardLayoutProvider)
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
}
