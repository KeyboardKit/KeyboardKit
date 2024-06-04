//
//  KeyboardSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-03-30.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This observable class can be used to manage settings for
/// the ``Keyboard`` namespace.
///
/// This type also contains some utility functions and state
/// that are shared by settings-related types in the library.
///
/// The static ``registerKeyboardSettingsStore(_:keyPrefix:)``
/// can be used to setup a shared keyboard settings instance.
/// The static ``store`` will then be used by settings types
/// within the library. You can also set this store directly.
///
/// This is how you replace this default store with a custom
/// store that syncs changes between an app and its keyboard:
///
/// ```swift
/// KeyboardSettings.registerStore(.init(suiteName: "app-group-id"))
/// ```
///
/// You can also specify a custom key prefix, that will then
/// be added before the persisted data. The default value is
/// `"com.keyboardkit.settings."`. The various namespaces in
/// the library then use ``storeKeyPrefix(for:)`` to setup a
/// unique prefix for that namespace.
///
/// > Important: Since `@AppStorage` properties will use the
/// ``store`` instance that's available when a first call to
/// the property is made, you must register any custom store
/// BEFORE setting up KeyboardKit.
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
    static func registerKeyboardSettingsStore(
        _ store: UserDefaults?,
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
