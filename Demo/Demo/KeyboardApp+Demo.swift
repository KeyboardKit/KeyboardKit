//
//  KeyboardApp+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-08-19.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

#if IS_KEYBOARDKIT
import KeyboardKit
#else
import KeyboardKit
#endif

extension KeyboardApp {

    /// This `KeyboardApp` value defines the demo app.
    ///
    /// The demo uses a `KeyboardKit.license` file to unlock
    /// KeyboardKit Pro, without having to include a license
    /// key in the app information below. This also lets the
    /// app update its license without also having to update
    /// KeyboardKit version. Note that this file is added to
    /// both the app and the `KeyboardPro` keyboard.
    ///
    /// The App Group ID is only to show you how you can use
    /// a `KeyboardApp` to set up App Group data syncing for
    /// an app and its keyboard. It doesn't work in the demo.
    /// 
    /// See `DemoApp.swift` for more info about the demo app.
    static var keyboardKitDemo: KeyboardApp {
        .init(
            name: "KeyboardKit Demo",
            // licenseKey: "299B33C6-061C-4285-8189-90525BCAF098",  // Sets up KeyboardKit Pro!
            appGroupId: "group.com.keyboardkit.demo",               // Sets up App Group data sync
            locales: .keyboardKitSupported,                         // Sets up the enabled locales
            autocomplete: .init(                                    // Sets up custom autocomplete
                // nextWordPredictionRequest: .claude(apiKey: "")   // Sets up AI-based prediction (add your own key)
            ),
            deepLinks: .init(
                app: "kkdemo://"                                    // Defines how to open the app
                // dictation: "kkdemo://dictation"                  // You can customize any default deep link
            )
        )
    }
}
