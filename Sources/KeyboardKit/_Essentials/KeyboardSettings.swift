//
//  KeyboardSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-03-30.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This class can be used to setup a custom value store for
/// all settings types in the library.
///
/// The static ``store`` is used to persist settings. It has
/// a ``Foundation/UserDefaults/keyboardSettings`` shorthand
/// for convenient access.
///
/// You can use ``setupStore(_:keyPrefix:)`` to register any
/// custom store, ``setupStore(withAppGroup:keyPrefix:)`` to
/// register a store that syncs settings between the app and
/// its keyboard extension (make sure to set up an App Group
/// first) or ``setupStore(for:)`` to use your ``KeyboardApp``.
///
/// > Important: `@AppStorage` properties will use the store
/// that's available when a property is first accessed. Make
/// sure to set up a custom store BEFORE the app or keyboard
/// extension accesses any settings.
public class KeyboardSettings: ObservableObject, LegacySettings {

    // MARK: - Deprecated: Settings are moved to the context.

    /// DEPRECATED - Settings are moved to the context.
    static let prefix = KeyboardSettings.storeKeyPrefix(for: "keyboard")

    /// DEPRECATED - Settings are moved to the context.
    @AppStorage("\(prefix)isAutocapitalizationEnabled", store: .keyboardSettings)
    public var isAutocapitalizationEnabled = true {
        didSet { triggerChange() }
    }

    @Published
    var lastChanged = Date()
}

extension KeyboardSettings {

    func syncToContextIfNeeded(
        _ context: KeyboardContext
    ) {
        guard shouldSyncToContext else { return }
        context.sync(with: self)
        updateLastSynced()
    }
}

public extension KeyboardSettings {

    /// The store that will be used by library settings.
    static var store: UserDefaults = .standard

    /// The key prefix that will be used by library settings.
    static var storeKeyPrefix = "com.keyboardkit.settings."

    /// Whether the ``store`` is synced with an App Group.
    static private(set) var storeIsAppGroupSynced = false

    /// Set up a custom settings store.
    ///
    /// - Parameters:
    ///   - store: The store instance to use.
    ///   - keyPrefix: A custom prefix to use for all store keys, if any.
    ///   - isAppGroupSynced: Whether the store syncs with an App Group, by default `nil`.
    static func setupStore(
        _ store: UserDefaults,
        keyPrefix: String? = nil,
        isAppGroupSynced: Bool = false
    ) {
        Self.store = store
        Self.storeKeyPrefix = keyPrefix ?? Self.storeKeyPrefix
        Self.storeIsAppGroupSynced = isAppGroupSynced
    }

    /// Set up a custom settings store for the provided `app`.
    ///
    /// This will set up App Group syncing if the app has an
    /// ``KeyboardApp/appGroupId`` specified.
    static func setupStore(
        for app: KeyboardApp
    ) {
        let prefix = app.keyboardSettingsKeyPrefix
        if let appGroup = app.appGroupId {
            setupStore(forAppGroup: appGroup, keyPrefix: prefix)
        } else {
            setupStore(.keyboardSettings, keyPrefix: prefix, isAppGroupSynced: false)
        }
    }

    /// Set up a custom settings store for a given App Group.
    ///
    /// - Parameters:
    ///   - appGroup: The ID of the App Group to use.
    ///   - keyPrefix: A custom prefix to use for all store keys, if any.
    static func setupStore(
        forAppGroup appGroup: String,
        keyPrefix: String? = nil
    ) {
        guard let store = UserDefaults(suiteName: appGroup) else { return }
        setupStore(store, keyPrefix: keyPrefix, isAppGroupSynced: true)
    }

    @available(*, deprecated, renamed: "setupStore(forAppGroup:keyPrefix:)")
    static func setupStore(
        withAppGroup appGroup: String,
        keyPrefix: String? = nil
    ) {
        setupStore(forAppGroup: appGroup, keyPrefix: keyPrefix)
    }

    @available(*, deprecated, message: "Setting an optional store is no longer allowed.")
    static func setupStore(
        _ store: UserDefaults?,
        keyPrefix: String? = nil
    ) {
        setupStore(store ?? .standard, keyPrefix: keyPrefix)
    }

    /// Get the store key prefix for a certain namespace.
    static func storeKeyPrefix(
        for namespace: String
    ) -> String {
        "\(Self.storeKeyPrefix)\(namespace)."
    }
}

public extension UserDefaults {

    /// This static instance can be used to persist keyboard
    /// related settings.
    ///
    /// See ``KeyboardSettings`` for more information on how
    /// to register a custom store.
    static var keyboardSettings: UserDefaults {
        get { KeyboardSettings.store }

        @available(*, deprecated, message: "Use KeyboardSettings.setupStore(...) instead")
        set { KeyboardSettings.store = newValue }
    }
}
