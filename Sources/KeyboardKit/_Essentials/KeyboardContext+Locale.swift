//
//  KeyboardContext+Locale.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {

    /// The locales that have been added by the user, if any.
    ///
    /// The ``selectNextLocale()`` function and context menu
    /// will use this list if it has locales, else ``locales``.
    ///
    /// > Note: Use ``addedLocaleIdentifiersValue`` whenever
    /// you want to bind this value to a picker.
    var addedLocales: [Locale] {
        get { addedLocaleIdentifiersValue.value.map(Locale.init) }
        set {
            let ids = newValue.map { $0.identifier }
            addedLocaleIdentifiersValue.value = Array(Set(ids))
        }
    }

    /// The locales that have been added by the user, if any.
    ///
    /// The ``selectNextLocale()`` function and context menu
    /// will use this list if it has locales, else ``locales``.
    ///
    /// > Note: Use ``addedLocaleIdentifiersValue`` whenever
    /// you want to bind this value to a picker.
    var addedLocaleIdentifiers: [String] {
        get { addedLocaleIdentifiersValue.value }
        set { addedLocaleIdentifiersValue.value = newValue }
    }

    /// Map the ``locale`` to a keyboard locale, if possible.
    var keyboardLocale: KeyboardLocale? {
        let match = KeyboardLocale.allCases.first { $0.matches(locale) }
        let fuzzy = KeyboardLocale.allCases.first { $0.matchesLanguage(in: locale) }
        return match ?? fuzzy
    }

    /// Whether a certain locale is selected.
    func hasKeyboardLocale(_ locale: KeyboardLocale) -> Bool {
        self.locale.identifier == locale.localeIdentifier
    }

    /// Select the next locale in ``locales``.
    ///
    /// This will loop through all locales in ``locales``.
    func selectNextLocale() {
        let locales = selectableLocales
        let fallback = locales.first ?? locale
        let firstIndex = locales.firstIndex(of: locale)
        guard let index = firstIndex else { return locale = fallback }
        let nextIndex = index.advanced(by: 1)
        guard locales.count > nextIndex else { return locale = fallback }
        locale = locales[nextIndex]
    }

    /// Set ``keyboardType`` to the provided type.
    func setKeyboardType(_ type: Keyboard.KeyboardType) {
        keyboardType = type
    }

    /// Set ``locale`` to the provided locale.
    func setLocale(_ locale: Locale) {
        self.locale = locale
    }

    /// Set ``locale`` to the provided keyboard locale.
    func setLocale(_ locale: KeyboardLocale) {
        self.locale = locale.locale
    }

    /// Set ``locales`` to the provided locales.
    func setLocales(_ locales: [Locale]) {
        self.locales = locales
    }

    /// Set ``locales`` to the provided keyboard locales.
    func setLocales(_ locales: [KeyboardLocale]) {
        self.locales = locales.map { $0.locale }
    }
}

extension KeyboardContext {

    /// This is internal until we find a better name for it.
    var selectableLocales: [Locale] {
        let hasAddedLocales = addedLocales.count > 1
        return hasAddedLocales ? addedLocales : locales
    }
}
