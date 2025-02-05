//
//  KeyboardSettings+AddedLocales.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-02-05.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardSettings {
    
    /// Whether settings has any added locales.
    var hasAddedLocales: Bool {
        !addedLocales.isEmpty
    }
    
    /// Whether settings has multiple added locales.
    var hasMultipleAddedLocales: Bool {
        addedLocales.count > 1
    }
    
    /// Whether a certain locale is added to ``addedLocales``.
    func firstAddedLocale(
        for locale: Locale
    ) -> Keyboard.AddedLocale? {
        addedLocales.first {
            $0.localeIdentifier == locale.identifier
        }
    }
    
    /// Whether a certain locale is added to ``addedLocales``.
    func firstAddedLocale(
        for locale: Locale,
        layoutType type: Keyboard.LayoutType? = nil
    ) -> Keyboard.AddedLocale? {
        addedLocales.first {
            $0.localeIdentifier == locale.identifier &&
            $0.layoutType?.id == type?.id
        }
    }

    /// Whether a locale has been added to ``addedLocales``.
    func hasAddedLocale(
        _ locale: Keyboard.AddedLocale
    ) -> Bool {
        addedLocales.contains(locale)
    }
    
    /// Whether a locale has been added to ``addedLocales``.
    func hasAddedLocale(
        _ locale: Locale
    ) -> Bool {
        firstAddedLocale(for: locale) != nil
    }
    
    /// Whether a locale with a certain layout type has been
    /// added to ``addedLocales``.
    func hasAddedLocale(
        _ locale: Locale,
        withLayoutType type: Keyboard.LayoutType
    ) -> Bool {
        firstAddedLocale(for: locale, layoutType: type) != nil
    }
}
