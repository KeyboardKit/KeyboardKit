//
//  KeyboardApp+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-08-19.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

#if IS_KEYBOARDKIT
import KeyboardKit
#else
import KeyboardKitPro
#endif

public extension KeyboardApp {

    /// This `KeyboardApp` value defines the demo app.
    ///
    /// The demo app has a `KeyboardKit.license` file that's
    /// linked to the app and the `KeyboardPro` keyboard. It
    /// unlocks KeyboardKit Pro without a `licenseKey` below.
    ///
    /// All yearly Gold and Enterprise customers can request
    /// a `KeyboardKit.license` file, while lower tiers must
    /// specify a `licenseKey`. License files let you update
    /// the license without having to update KeyboardKit Pro.
    ///
    /// The App Group ID is only to show you how you can use
    /// a `KeyboardApp` to set up App Group data syncing for
    /// an app and its keyboard. It doesn't work in the demo.
    /// See the ``DemoApp`` for more information.
    static var keyboardKitDemo: Self {
        .init(
            name: "KeyboardKit Demo",
            // licenseKey: "299B33C6-061C-4285-8189-90525BCAF098",  // The demo app uses a license file
            bundleId: "com.keyboardkit.demo",
            appGroupId: "group.com.keyboardkit.demo",
            locales: .keyboardKitSupported,
            autocomplete: .init(
                // nextWordPredictionRequest: .claude(apiKey: "")
            ),
            deepLinks: .init(app: "kkdemo://")
        )
    }
}
