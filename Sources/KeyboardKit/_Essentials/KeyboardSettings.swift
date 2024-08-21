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
/// The static ``store`` is used to persist changes for each
/// settings type. Use ``setupStore(_:keyPrefix:)`` to setup
/// a custom store, or ``setupStore(withAppGroup:keyPrefix:)``
/// to setup a store that syncs data between the app and its
/// keyboard extension, using an App Group.
///
/// You can also provide a custom ``storeKeyPrefix`` that is
/// added before each persisted value. The default prefix is
/// `"com.keyboardkit.settings."`.
///
/// > Important: `@AppStorage` properties will use the store
/// that's available when a property is first accessed. Make
/// sure to run ``setupStore(_:keyPrefix:)`` BEFORE your app
/// or keyboard extension accesses these settings properties.
public class KeyboardSettings: ObservableObject {

    /// DEPRECATED!
    ///
    /// > Warning: Settings are moved to ``KeyboardContext``.
    /// This will be removed in KeyboardKit 9.0.
    static let prefix = KeyboardSettings.storeKeyPrefix(for: "keyboard")

    /// DEPRECATED!
    ///
    /// > Warning: Settings are moved to ``KeyboardContext``.
    /// This will be removed in KeyboardKit 9.0.
    @AppStorage("\(prefix)isAutocapitalizationEnabled", store: .keyboardSettings)
    public var isAutocapitalizationEnabled = true {
        didSet { triggerChange() }
    }

    /// DEPRECATED!
    ///
    /// > Warning: Settings are moved to ``KeyboardContext``.
    /// This will be removed in KeyboardKit 9.0.
    @Published
    var lastChanged = Date()

    /// DEPRECATED!
    ///
    /// > Warning: Settings are moved to ``KeyboardContext``.
    /// This will be removed in KeyboardKit 9.0.
    @AppStorage("\(prefix)lastSynced", store: .keyboardSettings)
    var lastSynced = Keyboard.StorageValue(Date().addingTimeInterval(-3600))
}

extension KeyboardSettings {

    func syncToContextIfNeeded(
        _ context: KeyboardContext
    ) {
        guard lastSynced.value < lastChanged else { return }
        context.sync(with: self)
        lastSynced.value = Date()
    }
}

private extension KeyboardSettings {

    func triggerChange() {
        lastChanged = Date()
    }
}

public extension KeyboardSettings {

    /// The store that will be used by library settings.
    static var store: UserDefaults = .standard

    /// The key prefix that will be used by library settings.
    static var storeKeyPrefix = "com.keyboardkit.settings."

    /// Whether or not ``setupStore(withAppGroup:keyPrefix:)``
    /// has been used to replace ``store`` with an App Group
    /// synced store.
    static private(set) var storeisAppGroupSynced = false

    @available(*, deprecated, message: "Setting an optional store is no longer allowed.")
    static func setupStore(
        _ store: UserDefaults?,
        keyPrefix: String? = nil
    ) {
        setupStore(store ?? .standard, keyPrefix: keyPrefix)
    }

    /// Set up a custom keyboard settings store.
    static func setupStore(
        _ store: UserDefaults,
        keyPrefix: String? = nil,
        isAppGroupSynced: Bool = false
    ) {
        Self.store = store
        Self.storeKeyPrefix = keyPrefix ?? Self.storeKeyPrefix
        Self.storeisAppGroupSynced = isAppGroupSynced
    }

    /// Set up a custom keyboard settings store that uses an
    /// App Group to sync settings between multiple targets.
    ///
    /// > Important: For this function to work, you must set
    /// up an App Group for your app and register it for all
    /// targets. The function will throw an error if the App
    /// Group synced store could not be created.
    static func setupStore(
        withAppGroup id: String,
        keyPrefix: String? = nil
    ) {
        guard let store = UserDefaults(suiteName: id) else { return }
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
