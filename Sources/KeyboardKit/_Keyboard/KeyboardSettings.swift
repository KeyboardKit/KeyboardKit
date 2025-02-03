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
    }

    private let onAutocapitalizationEnabledChanged: () -> Void

    /// The settings key prefix to use.
    public static var settingsPrefix: String {
        KeyboardSettings.storeKeyPrefix(for: "keyboard")
    }

    /// A list of explicitly added locale identifiers.
    @AppStorage("\(settingsPrefix)addedLocaleIdentifiers", store: .keyboardSettings)
    public var addedLocaleIdentifiersValues: Keyboard.StorageValue<[String]> = .init(value: [])
    
    /// Whether auto-capitalization is enabled.
    @AppStorage("\(settingsPrefix)isAutocapitalizationEnabled", store: .keyboardSettings)
    public var isAutocapitalizationEnabled = true {
        didSet { onAutocapitalizationEnabledChanged() }
    }
    
    /// The input toolbar type to use, if any.
    @AppStorage("\(settingsPrefix)inputToolbarType", store: .keyboardSettings)
    public var inputToolbarType: InputToolbarType = .automatic
    
    /// The input toolbar chars to show for ``KeyboardSettings/InputToolbarType/characters``.
    @AppStorage("\(settingsPrefix)inputToolbarCharacters", store: .keyboardSettings)
    public var inputToolbarCharacters = ""
    
    /// The ``inputToolbarCharacters`` max length.
    @AppStorage("\(settingsPrefix)inputToolbarCharactersMaxLength", store: .keyboardSettings)
    public var inputToolbarCharactersMaxLength = 10

    /// Whether to auto-collapse the keyboard when connecting an external keyboard.
    @AppStorage("\(settingsPrefix)isKeyboardAutoCollapseEnabled", store: .keyboardSettings)
    public var isKeyboardAutoCollapseEnabled = false
    
    /// An optional edge to which the keyboard is docked.
    @AppStorage("\(settingsPrefix)keyboardDockEdge", store: .keyboardSettings)
    public var keyboardDockEdge: Keyboard.DockEdge?

    /// The identifier of the current locale, set by  ``KeyboardContext/locale``.
    @AppStorage("\(settingsPrefix)localeIdentifier", store: .keyboardSettings)
    public internal(set) var localeIdentifier = Locale.current.identifier
}


// MARK: - Added locales

public extension KeyboardSettings {

    /// A list of explicitly added locales.
    var addedLocales: [Locale] {
        get { addedLocaleIdentifiers.compactMap { Locale(identifier: $0) } }
        set { addedLocaleIdentifiers = newValue.unique().map { $0.identifier } }
    }

    /// A list of explicitly added locale identifiers.
    var addedLocaleIdentifiers: [String] {
        get { addedLocaleIdentifiersValues.value }
        set { addedLocaleIdentifiersValues.value = newValue }
    }

    /// Whether a locale has been added to ``addedLocales``.
    func hasAddedLocale(_ locale: Locale) -> Bool {
        addedLocales.contains(locale)
    }

    /// Move the provided locale first in ``addedLocales``.
    mutating func moveLocaleFirstInAddedLocales(_ locale: Locale) {
        if locale == addedLocales.first { return }
        addedLocales = addedLocales.insertingFirst(locale)
    }
}
