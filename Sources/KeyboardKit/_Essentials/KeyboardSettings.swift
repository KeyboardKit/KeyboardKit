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
    static var store: UserDefaults? = .standard

    /// The key prefix that will be used by library settings.
    static var storeKeyPrefix = "com.keyboardkit.settings."

    /// Set up a custom keyboard settings store.
    static func setupStore(
        _ store: UserDefaults?,
        keyPrefix: String? = nil
    ) {
        Self.store = store
        Self.storeKeyPrefix = keyPrefix ?? Self.storeKeyPrefix
    }

    /// Set up a custom keyboard settings store that uses an
    /// app group to sync settings between your main app and
    /// its keyboard extension.
    ///
    /// > Important: For this to work, you must first set up
    /// an App Group, then register it for both your app and
    /// the keyboard.
    static func setupStore(
        withAppGroup id: String,
        keyPrefix: String? = nil
    ) {
        Self.store = .init(suiteName: id)
        Self.storeKeyPrefix = keyPrefix ?? Self.storeKeyPrefix
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
    static var keyboardSettings: UserDefaults? {
        get { KeyboardSettings.store }
        set { KeyboardSettings.store = newValue }
    }
}
