//
//  DictationContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This context can be used to handle dictation state for apps
 and keyboard extensions.

 A ``DictationService`` can use the ``dictatedText`` to sync
 updates. A ``KeyboardDictationService`` can use the context
 to sync data between a keyboard extension and its app.
 */
public class DictationContext: ObservableObject {

    /**
     Create a context instance.
     */
    public init() {}

    private var userDefaults: UserDefaults?

    fileprivate enum PersistedKey: String {
        case localeId = "com.keyboardkit.dictation.localeId"
        case text = "com.keyboardkit.dictation.text"
    }

    /**
     The ID of the App Group that should be used to sync any
     dictation values between your main app and its keyboard.

     Setting this will setup a shared `UserDefaults` that is
     then used to sync changes between your app and keyboard.
     */
    public var appGroupId: String? {
        didSet {
            if let groupId = appGroupId {
                userDefaults = UserDefaults(suiteName: groupId)
                dictatedText = persistedDictatedText ?? dictatedText
                localeId = persistedLocaleId ?? localeId
            } else {
                userDefaults = nil
            }
        }
    }

    /**
     Whether or not dictation is in progress.
     */
    @Published
    public var isDictating = false

    /**
     The last dictated text.

     Set ``appGroupId`` to sync the value between a keyboard
     and its app.
     */
    @Published
    public var dictatedText = "" {
        didSet { persistedDictatedText = dictatedText }
    }

    /**
     The last inserted dictated text.

     This can be used to undo the last inserted dictation if
     the dictated text turned out bad.
     */
    @Published
    public var lastInsertedText: String?

    /**
     The locale identifier that is currently used to dictate.

     Set ``appGroupId`` to sync the value between a keyboard
     and its app.
     */
    @Published
    public var localeId = Locale.current.identifier {
        didSet {
            dictatedText = ""
            persistedLocaleId = localeId
        }
    }

    /**
     This property is used to keep a strong reference to the
     dictation service in the app.
     */
    @Published
    public var service: KeyboardDictationService?
}

public extension DictationContext {

    /**
     Reset the context.
     */
    func reset() {
        isDictating = false
        dictatedText = ""
    }

    /**
     Set ``isDictating`` with an animation.
     */
    func setIsDictating(_ value: Bool) {
        withAnimation {
            isDictating = value
        }
    }
}

private extension DictationContext {

    func string(for key: PersistedKey) -> String? {
        userDefaults?.string(forKey: key.rawValue)
    }

    func setString(_ string: String?, for key: PersistedKey) {
        userDefaults?.set(string, forKey: key.rawValue)
    }

    var persistedDictatedText: String? {
        get { string(for: .text) }
        set { setString(newValue, for: .text) }
    }

    var persistedLocaleId: String? {
        get { string(for: .localeId) }
        set { setString(newValue, for: .localeId) }
    }
}
