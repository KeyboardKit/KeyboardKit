//
//  DictationConfig+App.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-03.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit

extension Dictation.KeyboardConfiguration {

    /**
     This config is used to show how dictation can be set up
     for an app and its keyboard.

     > Note: Your app and keyboard should be able to share a.
     This demo must however use separate ones, since the app
     uses KeyboardKit and the keyboard uses KeyboardKit Pro.

     > Important: This is only for instruction purposes. The
     app isn't configured for dictation, since that requires
     it to be signed. You can open the app from the keyboard
     and start dictation, but the keyboard isn't able to get
     the dictated text, since the data isn't shared.
     */
    static let app = Dictation.KeyboardConfiguration(
        appGroupId: "com.keyboardkit.demo",
        appDeepLink: "kkdemo://dictation")
}
