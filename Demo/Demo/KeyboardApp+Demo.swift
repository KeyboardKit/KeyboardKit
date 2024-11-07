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

    /// This value defines the demo app.
    ///
    /// The demo app has a license file in `Supporting Files`
    /// that is linked to the app and `KeyboardPro`. This is
    /// why the `licenseKey` below is disabled. The app uses
    /// this license file instead of a binary or API license.
    ///
    /// All yearly Gold customers get a `KeyboardKit.license`
    /// file, that they can add to their app in the same way.
    /// If you are a Basic, Silver, or monthly Gold customer,
    /// you must specify your license key like below.
    ///
    /// The App Group ID is only to show you how you can use
    /// a `KeyboardApp` to set up App Group data syncing for
    /// an app and its keyboard. It doesn't work in the demo,
    /// since the demo isn't code signed.
    ///
    /// See ``DemoApp`` for mode important information about
    /// this demo.
    static var demoApp: Self {
        .init(
            name: "KeyboardKit Demo",
            // licenseKey: "299B33C6-061C-4285-8189-90525BCAF098",
            bundleId: "com.keyboardkit.demo",
            appGroupId: "group.com.keyboardkit.demo",
            locales: .keyboardKitSupported,
            deepLinks: .init(app: "kkdemo://")
        )
    }
}
