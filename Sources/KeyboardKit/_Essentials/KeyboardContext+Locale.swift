//
//  KeyboardContext+Locale.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {

    /// Map ``locale`` to a ``KeyboardLocale``, if possible.
    var keyboardLocale: KeyboardLocale? {
        let match = KeyboardLocale.allCases.first { $0.matches(locale) }
        let fuzzy = KeyboardLocale.allCases.first { $0.matchesLanguage(in: locale) }
        return match ?? fuzzy
    }

    /// Whether a certain locale is the current ``locale``.
    func hasCurrentLocale(_ locale: KeyboardLocale) -> Bool {
        self.locale.identifier == locale.localeIdentifier
    }

    /// Select the next locale in the selectable locales.
    func selectNextLocale() {
        let locales = selectableLocales
        let fallback = locales.first ?? locale
        let firstIndex = locales.firstIndex(of: locale)
        guard let index = firstIndex else { return locale = fallback }
        let nextIndex = index.advanced(by: 1)
        guard locales.count > nextIndex else { return locale = fallback }
        locale = locales[nextIndex]
    }

    /// Set ``locale`` to the provided locale.
    func setLocale(_ locale: Locale) {
        self.locale = locale
    }

    /// Set ``locale`` to the provided keyboard locale.
    func setLocale(_ locale: KeyboardLocale) {
        self.locale = locale.locale
    }
}
