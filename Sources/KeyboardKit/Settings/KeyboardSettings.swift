//
//  KeyboardSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-03-30.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This type is a namespace for settings-related types.
///
/// This type also contains some utility functions and state
/// that are shared by various settings-related types. Other
/// namespaces define namespace-specific settings types that
/// depend on types in this namespace.
///
/// The static ``registerKeyboardSettingsStore(_:keyPrefix:)``
/// can be used to setup a shared keyboard settings instance.
/// The static ``store`` will then be used by settings types
/// within the library. You can also set this store directly.
///
/// This is how you replace this default store with a custom
/// store that syncs changes between an app and its keyboard
/// extension, using an App Group:
///
/// ```swift
/// KeyboardSettings.registerStore(.init(suiteName: "app-group-id"))
/// ```
///
/// You can also specify a custom key prefix, that will then
/// be added before the persisted data. The default value is
/// "com.keyboardkit.settings.".
///
/// > Important: Since `@AppStorage` properties will use the
/// `store` instance that is available on the first call, do
/// make sure to register any custom store before setting up
/// KeyboardKit, since that will also setup settings-related
/// types that will read these values.
public struct KeyboardSettings {

    /// A prefix that will be added to all keyboard settings
    /// related keys.
    public static var store: UserDefaults? = .standard

    /// A prefix that will be added to all keyboard settings
    /// related keys.
    public static var storeKeyPrefix = "com.keyboardkit.settings."
}

public extension KeyboardSettings {

    /// Setup a custom keyboard settings store.
    func registerKeyboardSettingsStore(
        _ store: UserDefaults?,
        keyPrefix: String? = nil
    ) {
        Self.store = store
        Self.storeKeyPrefix = keyPrefix ?? Self.storeKeyPrefix
    }
}

public extension UserDefaults {

    /// This static instance can be used to persist keyboard
    /// related settings.
    ///
    /// See ``KeyboardSettings`` for more information on how
    /// to register a custom store.
    static var keyboardSettings: UserDefaults? {
        KeyboardSettings.store
    }
}
