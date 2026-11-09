//
//  KeyboardApp+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-08-19.
//  Copyright © 2024-2026 Kankoda. All rights reserved.
//

import KeyboardKit

// 💡 Autocomplete
import KeyboardKitAutocompletePlugin
extension PluginAutocompleteEngine: @retroactive AutocompleteEngine {}

// 💡 Dictation
import KeyboardKitDictationPlugin
extension PluginDictationEngine: @retroactive DictationEngine {}

extension KeyboardApp {

    /// This `KeyboardApp` value is specific to the demo app.
    ///
    /// Note that this file is added to both the app and the
    /// `Keyboard` keyboard extension.
    ///
    /// `IMPORTANT` This app isn't code signed and therefore
    /// can't use an App Group. This means that the settings
    /// won't sync between the app and the keyboard. The app
    /// just adds the `appGroupId` value to show how you can
    /// enable App Group data syncing.
    static var keyboardKitDemo: KeyboardApp {
        .init(
            name: "KeyboardKit Demo",
            licenseKey: "299B33C6-061C-4285-8189-90525BCAF098",     // KeyboardKit Pro License!
            appGroupId: "group.com.keyboardkit.demo",               // Set up App Group data sync
            locales: .keyboardKitSupported,                         // Set up the enabled locales
            autocomplete: .init(                                    // Set up custom autocomplete
                // nextWordPredictionRequest: .claude(apiKey: "")   // Set up AI-based prediction (add your own key)
            ),
            deepLinks: .init(
                app: "kkdemo://"                                    // Defines how to open the app
                // dictation: "kkdemo://dictation"                  // You can customize any default deep link
            )
        )
    }
}

@MainActor
var dictationEngine: DictationEngine {
    pluginDictationEngine
}

@MainActor
var autocompleteEngine: AutocompleteEngine {
    pluginAutocompleteEngine(
        .langlot(
            licenseKey: "87170FBB-24F4-4C00-A7FC-C9A77D49DF38",
            appGroup: KeyboardApp.keyboardKitDemo.appGroupId!
        )
    )
}
