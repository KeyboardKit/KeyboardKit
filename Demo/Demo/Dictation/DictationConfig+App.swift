//
//  DictationConfig+App.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-03.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro

extension Dictation.KeyboardConfiguration {

    /// This is how you define a shared dictation config for
    /// an app and its keyboard extension.
    ///
    /// Note that this demo app can't start dictation, since
    /// it requires a signed App Group to share data between
    /// the app and the keyboard. The app can be opened from
    /// the keyboard to start dictation, but the keyboard is
    /// not able to access the dictated text.
    static let app = Dictation.KeyboardConfiguration(
        appGroupId: "group.com.keyboardkit.demo",
        appDeepLink: "kkdemo://dictation"
    )
}
