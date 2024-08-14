//
//  KeyboardContext+Locale.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {

    /// The locale identifiers that have manually been added
    /// by the user, if any.
    ///
    /// This is a settings value that should not be mixed up
    /// with ``locales``, which defines all locales that are
    /// currently available to the keyboard.
    ///
    /// > Note: Use ``addedLocaleIdentifiersValue`` when you
    /// want to bind this value to a picker.
    var addedLocales: [Locale] {
        get { addedLocaleIdentifiersValue.value.map(Locale.init) }
        set {
            let ids = newValue.map { $0.identifier }
            addedLocaleIdentifiersValue.value = Array(Set(ids))
            nextLocaleMode = .addedLocales
        }
    }

    /// The locale identifiers that have manually been added
    /// by the user, if any.
    ///
    /// > Note: Use ``addedLocaleIdentifiersValue`` when you
    /// want to bind this value to a picker.
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

    /// Whether or not the context has a certain locale.
    func hasKeyboardLocale(_ locale: KeyboardLocale) -> Bool {
        self.locale.identifier == locale.localeIdentifier
    }

    /// Whether or not a certain keyboard type is selected.
    func hasKeyboardType(_ type: Keyboard.KeyboardType) -> Bool {
        keyboardType == type
    }

    /// Select the next locale in ``locales``.
    ///
    /// This will loop through all locales in ``locales``.
    func selectNextLocale() {
        let fallback = locales.first ?? locale
        guard let currentIndex = locales.firstIndex(of: locale) else { return locale = fallback }
        let nextIndex = currentIndex.advanced(by: 1)
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
