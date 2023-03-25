//
//  DictationContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This class can be used to keep track of dictation state for
 an app, for instance when using a dictation service.

 Since keyboard extensions can't access the microphone, your
 keyboard extension must open the main app, then let the app
 start dictation, then write the result to ``transcribedText``
 when dictation stops, then navigate back to the keyboard in
 which the transcribed text can be handled.

 For this to work, ``transcribedText`` must be stored within
 an App Group that is shared between an app and its keyboard,
 so the two can exchange data. Just set ``appGroupId`` to an
 ID that you are using in your app, to make the context sync
 ``transcribedText`` accordingly. This is automatically done
 when you are using the standard keyboard dictation service.

 KeyboardKit automatically creates an instance of this class
 and binds the created instance to the keyboard controller's
 ``KeyboardInputViewController/dictationContext``.
 */
class DictationContext: ObservableObject {

    /**
     Create a context instance.
     */
    init() {
        transcribedText = persistedText ?? ""
    }

    private var userDefaults = UserDefaults()

    private var userDefaultsKey = "com.keyboardkit.dictation.text"


    /**
     The ID of an App Group that should be used to share the
     dictation result between the main app and other targets.
     */
    var appGroupId: String = "com.keyboardkit.com" {
        didSet {
            let newDefaults = UserDefaults(suiteName: appGroupId)
            if newDefaults == nil { print("DictationContext: Failed to create a UserDefaults for \(appGroupId)")}
            userDefaults = newDefaults ?? userDefaults
            transcribedText = persistedText ?? ""
        }
    }

    /**
     Whether or not dictation is in progress.
     */
    @Published
    var isDictating = false

    /**
     The last transcribed text.
     */
    @Published
    var transcribedText = "" {
        didSet { persistedText = transcribedText }
    }
}

extension DictationContext {

    var persistedText: String? {
        get { userDefaults.string(forKey: userDefaultsKey) }
        set { userDefaults.set(newValue, forKey: userDefaultsKey) }
    }
}
