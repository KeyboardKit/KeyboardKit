//
//  DictationConfig+App.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-03.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro

extension Dictation.KeyboardConfiguration {

    /// This is how you can define a shared dictation config
    /// for an app and its keyboard extension.
    ///
    /// See ``DemoApp`` for important information about some
    /// limitations that this app has, since it's not signed.
    static let app = Dictation.KeyboardConfiguration(
        appGroupId: "group.com.keyboardkit.demo",
        appDeepLink: "kkdemo://dictation"
    )
}
