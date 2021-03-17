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
 
 This keyboard manually registers demo-specific services, to
 show you how it's done. It has also copied a Swedish locale
 set from KeyboardKit Pro to show you how to add more locale
 services to your own keyboard without using KeyboardKit Pro.
 
 `IMPORTANT` To use this keyboard, you must enable it in the
 system keyboard settings ("Settings/General/Keyboards"). It
 needs full access for haptic and audio feedback, for access
 to the user's photos etc.
 
 If you want to use these features in your own app, you must
 add `RequestsOpenAccess` to the extension's `Info.plist` to
 make it possible to enable full access. To access the photo
 album, you have to add a `NSPhotoLibraryAddUsageDescription`
 key to the `host` application's `Info.plist`.
 */
class KeyboardViewController: KeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        
        // Perform the bae initialization
        super.viewDidLoad()
        
        // Setup a demo-specific autocomplete suggestion provider
        // 💡 This will be overwritten if registering pro below
        autocompleteSuggestionProvider = DemoAutocompleteSuggestionProvider()
        
        // Setup the demo to explicitly use English locale
        // 💡 Change this if you want to try some other locales
        keyboardContext.locale = KeyboardLocale.english.locale
        
        // Setup the locales that the keyboard supports
        // 💡 This will be overwritten if registering pro below
        keyboardContext.locales = [
            KeyboardLocale.english.locale,
            KeyboardLocale.swedish.locale    // The demo has additional Swedish support
        ]
        
        // Setup a custom action handler to handle images
        keyboardActionHandler = DemoKeyboardActionHandler(
            inputViewController: self,
            toastContext: toastContext)
        
        // Setup an input set provider with multiple locales
        // 💡 This will be overwritten if registering pro below.
        keyboardInputSetProvider = StandardKeyboardInputSetProvider(
            context: keyboardContext,
            providers: [
                EnglishKeyboardInputSetProvider(),
                SwedishKeyboardInputSetProvider()])
        
        // Setup a layout with .emojis instead of .dictation
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            inputSetProvider: keyboardInputSetProvider,
            dictationReplacement: .keyboardType(.emojis))
        
        // Setup a secondary callout action provider with multiple locales
        // 💡 This will be overwritten if registering pro below.
        keyboardSecondaryCalloutActionProvider = StandardSecondaryCalloutActionProvider(
            context: keyboardContext,
            providers: [
                EnglishSecondaryCalloutActionProvider(),
                SwedishSecondaryCalloutActionProvider()])
        
        // keyboardAppearance can be used to style keyboards
        // keyboardAppearance = ColorTheme(context: keyboardContext)
        // view.backgroundColor = UIColor(keyboardAppearance.keyboardBackgroundColor)
        
        // Setup the extension to use the keyboardView below
        setup(with: keyboardView)
        
        // Setup KeyboardKit Pro. This unlocks more features.
        // Comment out this line to disable Pro mode.
        setupPro(withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098", view: keyboardView)
    }
    
    
    // MARK: - Properties
    
    private lazy var toastContext = KeyboardToastContext()
    
    private var keyboardView: some View {
        KeyboardView(
            actionHandler: keyboardActionHandler,
            appearance: keyboardAppearance,
            layoutProvider: keyboardLayoutProvider)
            .environmentObject(toastContext)
    }
    
    
    // MARK: - Autocomplete
    
    override func performAutocomplete() {
        super.performAutocomplete()
    }
}

//class ColorTheme: StandardKeyboardAppearance {
//
//    let blue = Color(red: 0, green: 70.0/255.0, blue: 180.0/255.0, opacity: 1)
//    let yellow = Color(hue: 44, saturation: 87, brightness: 0.60)
//
//    override func buttonCornerRadius(for action: KeyboardAction) -> CGFloat {
//        15
//    }
//
//    override var keyboardBackgroundColor: Color { blue }
//
//    override func buttonForegroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
//        action.isSystemAction ? super.buttonForegroundColor(for: action, isPressed: isPressed) : blue
//    }
//
//    override func buttonBackgroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
//        action.isSystemAction ? .yellow : super.buttonBackgroundColor(for: action, isPressed: isPressed)
//    }
//}
