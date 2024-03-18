//
//  DictationContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

/**
 This context can be used to handle regular in-app dictation
 and keyboard-based dictation.

 The context is used by both ``DictationService`` as well as
 ``KeyboardDictationService``. Use the initializer that fits
 your use-case when implementing dictation.

 For keyboard dictation, make sure to set up an app-specific
 ``Dictation/KeyboardConfiguration`` that is configured with
 a deeplink that opens the app to start dictation and an app
 group that is registered for both your app and its keyboard.
 
 Your app must create an instance of this context using your
 app-specific configuration, then bind it to your app's root
 view with `.keyboardDictation(...)`. The keyboard extension
 will get a context instance from the controller, and should
 then call ``setup(with:)`` with the same configuration.
 
 KeyboardKit automatically creates an instance of this class
 and binds it to ``KeyboardInputViewController/state``.
 */
public class DictationContext: ObservableObject {

    /// Create a keyboard dictation context for a keyboard.
    internal init() {
        setupAppGroup()
    }
    
    /// Create a keyboard dictation context for an app.
    public init(config: Dictation.KeyboardConfiguration) {
        setup(with: config)
    }

    /// Create a in-app dictation context for an app.
    public init(config: Dictation.Configuration) {
        localeId = config.localeId
    }


    private var userDefaults: UserDefaults?


    /// This enum defines keys that are used to persist data.
    public enum PersistedKey: String {
        case appGroupId
        case hostApplicationBundleId
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
     The deep link that should be used to open the app, when
     dictation is started from a keyboard extension.
     */
    public var appDeepLink: String?

    /**
     The currently dictated text, which can be observed from
     your app, and will be applied when dictation ends.
     */
    @Published
    public var dictatedText = "" {
        didSet { persistedDictatedText = dictatedText }
    }
    
    /**
     The bundle ID of the app that is using the keyboard.
     */
    @Published
    public var hostApplicationBundleId: String? {
        didSet { persistedHostApplicationBundleId = hostApplicationBundleId }
    }

    /**
     Whether or not dictation is currently in progress.
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
     The last applied dictation error, which can be observed
     and handled by the keyboard or app.
     */
    @Published
    public var lastError: Error?

    /**
     The last inserted dictated text, which can be used when
     you want to undo the last inserted dictation result.
     */
    @Published
    public var lastInsertedText: String?
    
    /**
     The locale identifier that is currently used to dictate.
     */
    @Published
    public var localeId = Locale.current.identifier {
        didSet { persistedLocaleId = localeId }
    }

    /**
     This service keeps a strong reference to your dictation
     service, while dictation is ongoing.
     */
    @Published
    public var service: KeyboardDictationService?

    /**
     The seconds of silence after which the dictation should
     automatically stop, to let users finish by stop talking.
     */
    @Published
    public var silenceLimit: TimeInterval = 10 {
        didSet { persistedSilenceLimit = silenceLimit }
    }
}

public extension DictationContext {

    /// Reset the context.
    func reset() {
        isDictating = false
        isDictationStartedByKeyboard = false
        dictatedText = ""
    }

    /// Set ``isDictating`` with an animation.
    func setIsDictating(_ value: Bool) {
        withAnimation {
            isDictating = value
        }
    }

    /// Setup the context with an app-specific configuration.
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
        dictatedText = persistedDictatedText ?? dictatedText
        hostApplicationBundleId = persistedHostApplicationBundleId ?? hostApplicationBundleId
        isDictationStartedByKeyboard = persistedIsDictationStartedByKeyboard ?? isDictationStartedByKeyboard
        localeId = persistedLocaleId ?? localeId
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
    
    var persistedHostApplicationBundleId: String? {
        get { string(for: .hostApplicationBundleId) }
        set { set(newValue, for: .hostApplicationBundleId) }
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
