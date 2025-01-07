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
import KeyboardKitPro
#endif

public extension KeyboardApp {

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
    /// See the ``DemoApp`` for more information.
    static var keyboardKitDemo: Self {
        .init(
            name: "KeyboardKit Demo",
            // licenseKey: "299B33C6-061C-4285-8189-90525BCAF098",  // The demo uses a license file
            bundleId: "com.keyboardkit.demo",
            appGroupId: "group.com.keyboardkit.demo",               // The demo doesn't have an app group
            locales: .keyboardKitSupported,                         // This list is capped to your license
            autocomplete: .init(
                // nextWordPredictionRequest: .claude(apiKey: "")   // Add your own key to test this
            ),
            deepLinks: .init(
                app: "kkdemo://"                                    // This can be used to open your app
                // dictation: "kkdemo://dictation"                  // This is the default url for the app url
            )
        )
    }
}
