//
//  DictationContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

/**
 This context can be used to handle regular in-app dictation
 and keyboard-based dictation.

 The context is used by both ``DictationService`` as well as
 ``KeyboardDictationService``. Use the initializer that fits
 your use-case.

 For an app to support keyboard-based dictation, it must use
 an app-specific ``Dictation/KeyboardConfiguration`` that is
 configured with a deep link that will open the app to start
 the dictation operation, and an app group that's registered
 for both the app and the keyboard.
 
 A keyboard extension will get a context from its controller,
 and must call ``setup(with:)`` with the app-specific config
 to setup the context. An app must create a context instance
 using the same configuration, then bind it to the root view
 with the `.keyboardDictation(...)` view extension.
 */
public class DictationContext: ObservableObject {

    /**
     Create a context for a keyboard extension.
     */
    internal init() {
        setupAppGroup()
    }

    /**
     Create a context for an app and basic in-app dictation.
     */
    public init(config: Dictation.Configuration) {
        localeId = config.localeId
    }

    /**
     Create a context for an app and keyboard dictation.
     */
    public init(config: Dictation.KeyboardConfiguration) {
        setup(with: config)
    }


    private var userDefaults: UserDefaults?


    /// This enum defines keys that are used to persist data.
    public enum PersistedKey: String {
        case appGroupId
        case isDictationStartedByKeyboard
        case localeId
        case silenceLimit
        case text

        public var key: String { "com.keyboardkit.dictation.\(rawValue)" }
    }

    /**
     The ID of the App Group that should be used to sync any
     dictation values between your main app and its keyboard.

     The value is persisted to be available to your keyboard
     when it returns, before your setup code has been called.
     */
    @AppStorage(PersistedKey.appGroupId.key)
    public var appGroupId: String? {
        didSet { setupAppGroup() }
    }

    /**
     The deep link to use to open the app, when initializing
     a dictation operation from a keyboard extension.
     */
    public var appDeepLink: String?

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
     Whether or not dictation is in progress.
     */
    @Published
    public var isDictating = false

    /**
     Whether or not dictation has been started by a keyboard.
     */
    @Published
    public var isDictationStartedByKeyboard = false {
        didSet { persistedIsDictationStartedByKeyboard = isDictationStartedByKeyboard }
    }

    /**
     The last applied dictation error.

     This can be written by any dictation that isn't handled
     manually, to expose errors that need to be handled.
     */
    @Published
    public var lastError: Error?

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
        didSet { persistedLocaleId = localeId }
    }

    /**
     This property is used to keep a strong reference to the
     dictation service, while dictation is ongoing.
     */
    @Published
    public var service: KeyboardDictationService?

    /**
     The time in seconds after which a dictation should stop,
     to let users finish without having to tap a button.

     This is by default set to `30` seconds, since a shorter
     time limit may be unexpected. If you decide to go use a
     long time limit, make sure to also add a done button to
     give users a chance to manually finish dictation.
     */
    @Published
    public var silenceLimit: TimeInterval = 30 {
        didSet { persistedSilenceLimit = silenceLimit }
    }
}

public extension DictationContext {

    /**
     Reset the context.
     */
    func reset() {
        isDictating = false
        isDictationStartedByKeyboard = false
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

    /**
     Set up the context with an app-specific configuration.

     This function must be called by a keyboard extension to
     make it able to start a keyboard dictation operation.
     */
    func setup(with config: Dictation.KeyboardConfiguration) {
        appDeepLink = config.appDeepLink
        appGroupId = config.appGroupId
        setupAppGroup()
    }
}

private extension DictationContext {

    func setupAppGroup() {
        guard let id = appGroupId else { return }
        guard let store = UserDefaults(suiteName: id) else { return }
        userDefaults = store
        localeId = persistedLocaleId ?? localeId
        dictatedText = persistedDictatedText ?? dictatedText
        isDictationStartedByKeyboard = persistedIsDictationStartedByKeyboard ?? isDictationStartedByKeyboard
        silenceLimit = persistedSilenceLimit
    }


    func bool(for key: PersistedKey) -> Bool? {
        userDefaults?.bool(forKey: key.key)
    }

    func double(for key: PersistedKey) -> Double? {
        hasValue(for: key) ? userDefaults?.double(forKey: key.key) : nil
    }

    func integer(for key: PersistedKey) -> Int? {
        userDefaults?.integer(forKey: key.key)
    }

    func string(for key: PersistedKey) -> String? {
        userDefaults?.string(forKey: key.key)
    }


    func set(_ value: Bool?, for key: PersistedKey) {
        userDefaults?.set(value, forKey: key.key)
    }

    func set(_ value: Double?, for key: PersistedKey) {
        userDefaults?.set(value, forKey: key.key)
    }

    func set(_ value: Int?, for key: PersistedKey) {
        userDefaults?.set(value, forKey: key.key)
    }

    func set(_ value: String?, for key: PersistedKey) {
        userDefaults?.set(value, forKey: key.key)
    }


    func hasValue(for key: PersistedKey) -> Bool {
        userDefaults?.object(forKey: key.key) != nil
    }
    

    var persistedDictatedText: String? {
        get { string(for: .text) }
        set { set(newValue, for: .text) }
    }

    var persistedIsDictationStartedByKeyboard: Bool? {
        get { bool(for: .isDictationStartedByKeyboard) }
        set { set(newValue, for: .isDictationStartedByKeyboard) }
    }

    var persistedLocaleId: String? {
        get { string(for: .localeId) }
        set { set(newValue, for: .localeId) }
    }

    var persistedSilenceLimit: TimeInterval {
        get {
            let value = double(for: .silenceLimit) ?? 0
            let hasValue = value > 0
            return hasValue ? value : 30
        }
        set { set(newValue, for: .silenceLimit) }
    }
}
