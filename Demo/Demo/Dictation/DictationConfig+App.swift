//
//  DictationConfig+App.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-03.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit

extension KeyboardDictationConfiguration {

    /**
     This config is used to show how dictation can be set up
     for an app and its keyboard.

     > Note: Your app will most likely be able to share this
     config between the app and the keyboard. This demo must
     however use two configs, since the app uses KeyboardKit
     and the keyboard uses KeyboardKit Pro.     

     > Important: This is only for instruction purposes. The
     app group is NOT configured for the demo, since it must
     be signed. You will be able to start dictation from the
     demo keyboard, but the keyboard will not be able to get
     hold of the dictated text once you return.
     */
    static let app = KeyboardDictationConfiguration(
        appGroupId: "com.keyboardkit.demo",
        appDeepLink: "kkdemo://dictation")
}
