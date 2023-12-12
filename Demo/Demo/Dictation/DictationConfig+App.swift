//
//  DictationConfig+App.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-03.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro

extension Dictation.KeyboardConfiguration {

    /**
     This is how you define a shared dictation config for an
     app and its keyboard extension.
     
     Note that this app can't use dictation, since dictation
     requires an App Group to share data between the app and
     its keyboard, which requires the app to be signed. This
     app can be opened from the keyboard and start dictation,
     but the keyboard isn't able to access the dictated text.
     */
    static let app = Dictation.KeyboardConfiguration(
        appGroupId: "group.com.keyboardkit.demo",
        appDeepLink: "kkdemo://dictation"
    )
}
