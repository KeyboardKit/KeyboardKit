//
//  KeyboardSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-26.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This type is used for essential keyboard settings.
///
/// All properties for this type are automatically stored in
/// ``KeyboardSettings/store`` with a `keyboard` prefix. You
/// can use ``Foundation/UserDefaults/keyboardSettings`` for
/// convenience when defining a user defaults value.
///
/// You can use ``setupStore(for:)`` to set up the store for
/// a ``KeyboardApp`` or use the parameter-based variant for
/// granular control. Make sure to first set up an App Group
/// for the app and keyboard and add its ID to the app value.
///
/// > Important: A `@AppStorage` property will use the store
/// that is available when it's first accessed. Make sure to
/// set up a custom store BEFORE accessing stored properties,
/// otherwise they will keep referring to the original store.
public struct KeyboardSettings {
    
    /// Create a custom settings instance.
    ///
    /// - Parameters:
    ///   - onAutocapitalizationEnabledChanged: The action to trigger when autocapitalization is changed.
    public init(
        onAutocapitalizationEnabledChanged: @escaping () -> Void = {}
    ) {
        self.onAutocapitalizationEnabledChanged = onAutocapitalizationEnabledChanged
        self.migrateAddedLocaleDataForKeyboardKit9_2()
    }
    
    private let onAutocapitalizationEnabledChanged: () -> Void
    
    /// The settings key prefix to use.
    public static var settingsPrefix: String {
        KeyboardSettings.storeKeyPrefix(for: "keyboard")
    }
    
    /// A list of explicitly added locale identifiers.
    @AppStorage("\(settingsPrefix)addedLocales", store: .keyboardSettings)
    public var addedLocales: [Keyboard.AddedLocale] = []
    
    /// The input toolbar type to use, if any.
    @AppStorage("\(settingsPrefix)inputToolbarType", store: .keyboardSettings)
    public var inputToolbarType: InputToolbarType = .automatic
    
    /// The input toolbar chars to show for ``KeyboardSettings/InputToolbarType/characters``.
    @AppStorage("\(settingsPrefix)inputToolbarCharacters", store: .keyboardSettings)
    public var inputToolbarCharacters = ""
    
    /// The ``inputToolbarCharacters`` max count.
    @AppStorage("\(settingsPrefix)inputToolbarCharactersMaxCount", store: .keyboardSettings)
    public var inputToolbarCharactersMaxCount = 10
    
    /// Whether auto-capitalization is enabled.
    @AppStorage("\(settingsPrefix)isAutocapitalizationEnabled", store: .keyboardSettings)
    public var isAutocapitalizationEnabled = true {
        didSet { onAutocapitalizationEnabledChanged() }
    }

    /// Whether to auto-collapse the keyboard when an external keyboard is connected.
    @AppStorage("\(settingsPrefix)isKeyboardAutoCollapseEnabled", store: .keyboardSettings)
    public var isKeyboardAutoCollapseEnabled = false
    
    /// The ``Keyboard/DockEdge`` to use, if any.
    @AppStorage("\(settingsPrefix)keyboardDockEdge", store: .keyboardSettings)
    public var keyboardDockEdge: Keyboard.DockEdge?
    
    /// The identifier of the current layout type, set by ``KeyboardContext/layoutType``.
    @AppStorage("\(settingsPrefix)keyboardLayoutTypeIdentifier", store: .keyboardSettings)
    public internal(set) var keyboardLayoutTypeIdentifier: Keyboard.LayoutType.ID?
    
    /// The identifier of the current locale, set by ``KeyboardContext/locale``.
    @AppStorage("\(settingsPrefix)localeIdentifier", store: .keyboardSettings)
    public internal(set) var localeIdentifier = Locale.current.identifier
    
    /// The ``Keyboard/SpaceLongPressBehavior`` to use for the space key.
    @AppStorage("\(settingsPrefix)spaceLongPressBehavior", store: .keyboardSettings)
    public var spaceLongPressBehavior = Keyboard.SpaceLongPressBehavior.moveInputCursor
    
    /// An optional trailing ``Keyboard/SpaceAction`` to add to the space key, if any.
    @AppStorage("\(settingsPrefix)spaceTrailingAction", store: .keyboardSettings)
    public var spaceTrailingAction: Keyboard.SpaceAction?
    
    
    // MARK: - Deprecated
    
    /// DEPRECATED: Use ``addedLocaleValues`` instead.
    ///
    /// This is kept to propertly deprecate the old property,
    /// while still being able to access the data internally.
    @AppStorage("\(settingsPrefix)addedLocaleIdentifiers", store: .keyboardSettings)
    var _addedLocaleIdentifiersValuesInternal: Keyboard.StorageValue<[String]> = .init(value: []) {
        didSet { self.migrateAddedLocaleDataForKeyboardKit9_2() }
    }
    
    @available(*, deprecated, message: "Use addedLocaleValues instead! This will automatically migrate.")
    public var addedLocaleIdentifiersValues: Keyboard.StorageValue<[String]> {
        get { _addedLocaleIdentifiersValuesInternal }
        set { _addedLocaleIdentifiersValuesInternal = newValue }
    }
    
    @available(*, deprecated, message: "Use addedLocaleValues instead! This will automatically migrate.")
    var addedLocaleIdentifiers: [String] {
        get { addedLocaleIdentifiersValues.value }
        set { addedLocaleIdentifiersValues.value = newValue }
    }
}

private extension KeyboardSettings {
    
    func migrateAddedLocaleDataForKeyboardKit9_2() {
        guard addedLocales.isEmpty else { return }
        let value = _addedLocaleIdentifiersValuesInternal.value
        if value.isEmpty { return }
        addedLocales = value.map { .init(localeIdentifier: $0) }
        _addedLocaleIdentifiersValuesInternal.value = []
    }
}
