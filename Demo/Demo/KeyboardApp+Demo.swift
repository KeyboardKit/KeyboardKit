//
//  KeyboardApp+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-08-19.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro

public extension KeyboardApp {

    /// This value defines properties for the demo app.
    ///
    /// The app doesn't support syncing data with App Groups,
    /// since it's not code signed, but it still defines one
    /// below, just to show you how it's done.
    ///
    /// The license key is demo-specific, and only works for
    /// this particular demo app. The bundle ID is used when
    /// presenting the keyboard status on the home screen.
    ///
    /// Note how this file is added to this main app and the
    /// `Pro` keyboard, to make it available in both targets.
    static var demoApp: Self {
        .init(
            name: "KeyboardKit Demo",
            licenseKey: "299B33C6-061C-4285-8189-90525BCAF098",
            bundleId: "com.keyboardkit.demo",
            appGroupId: "group.com.keyboardkit.demo",
            locales: .all,
            dictationDeepLink: "kkdemo://dictation"
        )
    }
}

public extension Dictation.KeyboardConfiguration {

    /// This configuration is derived from the demo app, but
    /// has a fallback in case that one doesn't work.
    static var app: Self {
        let config = KeyboardApp.demoApp.dictationConfiguration
        return config ?? .init(appGroupId: "", appDeepLink: "")
    }
}
