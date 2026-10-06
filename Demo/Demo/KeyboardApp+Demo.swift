//
//  KeyboardApp+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-08-19.
//  Copyright © 2024-2026 Kankoda. All rights reserved.
//

#if IS_KEYBOARDKIT
import KeyboardKit
#else
import KeyboardKit
#endif

extension KeyboardApp {

    /// This `KeyboardApp` value is specific to the demo app.
    ///
    /// Note that this file is added to both the app and the
    /// `Keyboard` keyboard extension.
    ///
    /// The demo uses a `KeyboardKit.license` file to unlock
    /// KeyboardKit Pro, which is why the `licenseKey` below
    /// is disabled. The `appGroupId` value is only added to
    /// show how to enable App Group data syncing, but since
    /// this demo app isn't code signed, it does not work in
    /// this demo. See ``DemoApp`` for more information.
    static var keyboardKitDemo: KeyboardApp {
        .init(
            name: "KeyboardKit Demo",
            // licenseKey: "299B33C6-061C-4285-8189-90525BCAF098",  // Set up KeyboardKit Pro!
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
