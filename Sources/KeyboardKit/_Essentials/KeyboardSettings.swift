//
//  KeyboardSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-03-30.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This observable class can be used to manage settings for
/// the ``Keyboard`` namespace, and to set up a custom store
/// for all settings classes.
///
/// The static ``store`` is used to persist changes for each
/// settings type. Use ``setupStore(_:keyPrefix:)`` to setup
/// a custom store for all settings data.
///
/// Settings data is by default isolated to each target, but
/// you can use ``setupStore(withAppGroup:keyPrefix:)`` when
/// you want to automatically sync data between your app and
/// its keyboard extension, using an App Group.
///
/// You can also provide a custom key prefix. The default is
/// `"com.keyboardkit.settings."`.
///
/// > Important: `@AppStorage` properties will use the store
/// that's available on the first access. Make sure to setup
/// a custom store BEFORE accessing any settings properties.
public class KeyboardSettings: ObservableObject {

    static let prefix = KeyboardSettings.storeKeyPrefix(for: "keyboard")

    @AppStorage("\(prefix)isAutocapitalizationEnabled", store: .keyboardSettings)
    public var isAutocapitalizationEnabled = true {
        didSet { triggerChange() }
    }

    @Published
    var lastChanged = Date()
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

    /// Setup a custom keyboard settings store.
    static func setupStore(
        _ store: UserDefaults?,
        keyPrefix: String? = nil
    ) {
        Self.store = store
        Self.storeKeyPrefix = keyPrefix ?? Self.storeKeyPrefix
    }

    /// Setup a custom keyboard settings store.
    static func setupStore(
        withAppGroup appGroup: UserDefaults?,
        keyPrefix: String? = nil
    ) {
        Self.store = store
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
