//
//  KeyboardContext+Locale.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {

    /// A list of explicitly added locales, which should not
    /// be confused with all available ``locales``.
    ///
    /// The ``selectNextLocale()`` function and context menu
    /// will use this list if it has locales, else ``locales``.
    ///
    /// > Note: Use ``addedLocaleIdentifiersValue`` whenever
    /// you want to bind this value to a picker.
    var addedLocales: [KeyboardLocale] {
        get {
            addedLocaleIdentifiersValue.value
                .compactMap { KeyboardLocale(rawValue: $0) }
        }
        set {
            let ids = newValue
                .unique()
                .map { $0.localeIdentifier }
            addedLocaleIdentifiersValue.value = ids
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

    /// Whether a locale has been added to ``addedLocales``.
    func hasAddedLocale(_ locale: KeyboardLocale) -> Bool {
        addedLocales.contains(locale)
    }

    /// Move the current ``locale`` first in ``addedLocales``.
    ///
    /// This will only be performed if the current locale is
    /// among the ``addedLocales``.
    func moveCurrentLocaleFirstInAddedLocales() {
        guard let keyboardLocale else { return }
        if keyboardLocale == addedLocales.first { return }
        addedLocales = [keyboardLocale] + addedLocales.filter { $0 != keyboardLocale }
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
        return hasAddedLocales ? addedLocales.map { $0.locale } : locales
    }
}
