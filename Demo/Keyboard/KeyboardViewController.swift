//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit
// import KeyboardKitPro
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
    
    override func viewDidLoad() {
        
        // Uncomment this line to customize when to use dark
        // appearance colors.
        // Color.darkAppearanceStrategy = { _ in false }
        
        // Setup a demo-specific autocomplete provider
        // 💡 You can create your own autocomplete providers
        // 💡 This is overwritten if Pro is registered below
        autocompleteProvider = FakeAutocompleteProvider()
        
        // Setup the demo to explicitly use English locale
        // 💡 This is already done and just here to show how
        // 💡 If you register Pro below, you get all locales
        keyboardContext.locale = KeyboardLocale.english.locale
        
        // Setup the locales that the keyboard supports
        // 💡 This is already done and just here to show how
        // 💡 This is overwritten if Pro is registered below
        keyboardContext.locales = [KeyboardLocale.english.locale]
        
        // Setup a custom, demo-specific action handler
        // 💡 Custom action handlers can handle custom logic
        keyboardActionHandler = DemoKeyboardActionHandler(
            inputViewController: self)
        
        // Setup an input set provider
        // 💡 This is already done and just here to show how
        // 💡 A keyboard input set specifies "input" actions
        // 💡 This is overwritten if Pro is registered below
        keyboardInputSetProvider = StandardKeyboardInputSetProvider(
            context: keyboardContext,
            providers: [EnglishKeyboardInputSetProvider()])
        
        // Setup a layout with .emojis instead of .dictation
        // 💡 A keyboard layout specifies the all keys/sizes
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            inputSetProvider: keyboardInputSetProvider,
            dictationReplacement: .keyboardType(.emojis))
        
        // Setup a secondary callout action provider
        // 💡 This is already done and just here to show how
        // 💡 This is overwritten if Pro is registered below
        keyboardSecondaryCalloutActionProvider = StandardSecondaryCalloutActionProvider(
            context: keyboardContext,
            providers: [EnglishSecondaryCalloutActionProvider()])
        
        // keyboardAppearance can be used to style keyboards
        // This demo will soon demonstrate a color theme
        // keyboardAppearance = <Insert your own custom appearance>
        // view.backgroundColor = UIColor(keyboardAppearance.keyboardBackgroundColor)
        
        // Perform the base initialization
        super.viewDidLoad()
    }
    
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        
        // Setup the extension to use the keyboardView below,
        // either without or with Pro enabled.
        setup(with: keyboardView)
        // try? setupPro(withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098", view: keyboardView)
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
