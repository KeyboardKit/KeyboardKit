//
//  Keyboard+SettingsStore.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-03-30.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard.Settings {

    /// The store that will be used by library settings.
    static var store: UserDefaults = .standard

    /// The key prefix that will be used by library settings.
    static var storeKeyPrefix = storeKeyPrefixDefault

    /// The default key prefix that will be used by library settings.
    static let storeKeyPrefixDefault = "com.keyboardkit.settings."

    /// Whether the ``store`` is synced with an App Group.
    static private(set) var storeIsAppGroupSynced = false

    /// Reset the standard settings store.
    static func resetStore() {
        setupStore(.standard, keyPrefix: storeKeyPrefixDefault)
    }

    /// Set up a custom settings store.
    ///
    /// - Parameters:
    ///   - store: The store instance to use.
    ///   - keyPrefix: A custom prefix to use for all store keys, if any.
    static func setupStore(
        _ store: UserDefaults,
        keyPrefix: String? = nil
    ) {
        setupStore(store, keyPrefix: keyPrefix, isAppGroupSynced: false)
    }

    /// Set up a custom settings store.
    ///
    /// - Parameters:
    ///   - store: The store instance to use.
    ///   - keyPrefix: A custom prefix to use for all store keys, if any.
    ///   - isAppGroupSynced: Whether the store syncs with an App Group.
    static func setupStore(
        _ store: UserDefaults,
        keyPrefix: String? = nil,
        isAppGroupSynced: Bool
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
            setupStore(.standard, keyPrefix: prefix)
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

    /// Get the store key prefix for a certain namespace.
    static func storeKeyPrefix(
        for namespace: String
    ) -> String {
        "\(Self.storeKeyPrefix)\(namespace)."
    }
}

public extension UserDefaults {

    /// This store to use to persist keyboard settings using
    /// the ``Keyboard/Settings/store``.
    static var keyboardSettings: UserDefaults {
        Keyboard.Settings.store
    }
}
