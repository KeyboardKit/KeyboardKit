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

/// This class has observable states and persistent settings,
/// as well as a couple of persisted properties that are not
/// considered settings, but carry state between the app and
/// its keyboard extension.
///
/// The context is used by both ``DictationService`` as well
/// as ``KeyboardDictationService``. Use an initializer that
/// fits your needs, as described in <doc:Dictation-Article>.
///
/// The ``dictatedText`` property is updated while dictation
/// is performed, together with many other properties, which
/// are used by the dictation services.
///
/// The ``silenceLimit`` settings can be used to control how
/// long time a user can be silent before the dictation will
/// automatically wrap up.
///
/// KeyboardKit will automatically setup an instance of this
/// class in ``KeyboardInputViewController/state``, then use
/// it as global state and inject it as an environment value.
///
/// > Important: KeyboardKit 9.0 will remove the manual data
/// persistency and replace it with @AppStorage.
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


    // MARK: - Settings

    static let prefix = KeyboardSettings.storeKeyPrefix(for: "dictation")

    /// The max number of seconds of silence after which the
    /// dictation operation will automatically finish.
    ///
    /// Stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(prefix)silenceLimit", store: .keyboardSettings)
    public var silenceLimit: TimeInterval = 5.0


    // MARK: - Properties

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

    /// The ID of the App Group to use to sync any dictation
    /// data between your main app and its keyboard.
    ///
    /// This is persisted in user defaults to stay available
    /// to your keyboard when it returns.
    @AppStorage(PersistedKey.appGroupId.key)
    public var appGroupId: String? {
        didSet { setupAppGroup() }
    }

    /// The deep link that should be used to open the app to
    /// start dictation from a keyboard extension.
    public var appDeepLink: String?

    /// The currently dictated text, which will update while
    /// dictation detects new text.
    ///
    /// This text can be observed from your app, and will be
    /// applied when dictation ends.
    @Published
    public var dictatedText = "" {
        didSet { persistedDictatedText = dictatedText }
    }
    
    /// The bundle ID of the app that is using the keyboard.
    @Published
    public var hostApplicationBundleId: String? {
        didSet { persistedHostApplicationBundleId = hostApplicationBundleId }
    }

    /// Whether dictation is currently in progress.
    @Published
    public var isDictating = false

    /// Whether dictation has been started by a keyboard.
    @Published
    public var isDictationStartedByKeyboard = false {
        didSet { persistedIsDictationStartedByKeyboard = isDictationStartedByKeyboard }
    }

    /// The last applied dictation error.
    @Published
    public var lastError: Error?

    /// The last inserted dictated text.
    ///
    /// This can be used to undo the last inserted dictation.
    @Published
    public var lastInsertedText: String?
    
    /// The locale identifier that is used to dictate.
    @Published
    public var localeId = Locale.current.identifier {
        didSet { persistedLocaleId = localeId }
    }

    /// A strong reference to the current dictation service.
    public var service: KeyboardDictationService?
}

public extension DictationContext {

    /// The keyboard configuration to use for the context.
    var keyboardConfiguration: Dictation.KeyboardConfiguration {
        .init(
            appGroupId: self.appGroupId ?? "",
            appDeepLink: self.appDeepLink ?? ""
        )
    }

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

extension DictationContext {

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
}

private extension DictationContext {

    func setupAppGroup() {
        guard let id = appGroupId else { return }
        guard let store = UserDefaults(suiteName: id) else { return }
        userDefaults = store
        DispatchQueue.main.async(execute: setupAppGroupProperties)
    }

    func setupAppGroupProperties() {
        dictatedText = persistedDictatedText ?? dictatedText
        hostApplicationBundleId = persistedHostApplicationBundleId ?? hostApplicationBundleId
        isDictationStartedByKeyboard = persistedIsDictationStartedByKeyboard ?? isDictationStartedByKeyboard
        localeId = persistedLocaleId ?? localeId
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
}
