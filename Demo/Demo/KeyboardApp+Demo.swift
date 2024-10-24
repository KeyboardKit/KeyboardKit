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

    /// This static app property defines the demo app.
    ///
    /// The license key is demo-specific, and only works for
    /// this particular demo app. The bundle ID is used when
    /// presenting the keyboard status on the home screen.
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
            licenseKey: "299B33C6-061C-4285-8189-90525BCAF098",
            bundleId: "com.keyboardkit.demo",
            appGroupId: "group.com.keyboardkit.demo",
            locales: .keyboardKitSupported,
            deepLinks: .init(app: "kkdemo://")
        )
    }
}
