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

    /// Whether a locale can be added to ``addedLocales``.
    func canAddLocaleToAddedLocales(_ locale: KeyboardLocale) -> Bool {
        !addedLocales.contains(locale.locale)
    }

    /// Whether a locale can be removed from ``addedLocales``.
    func canRemoveLocaleFromAddedLocales(_ locale: KeyboardLocale) -> Bool {
        addedLocales.contains(locale.locale) && !isLocaleSelected(locale)
    }

    /// Move locales in ``addedLocales``.
    func moveAddedLocales(
        fromOffsets source: IndexSet,
        toOffset destination: Int
    ) {
        addedLocales.move(fromOffsets: source, toOffset: destination)
        setLocale(addedLocales.first ?? KeyboardLocale.english.locale)
    }

    /// Move the current ``locale`` first in ``addedLocales``.
    func moveCurrentLocaleFirst() {
        guard let first = addedLocales.first else { return }
        if first == locale { return }
        addedLocales = [locale] + addedLocales.filter { $0 != locale }
    }

    /// Remove locales from ``addedLocales``.
    func removeLocale(at offsets: IndexSet) {
        addedLocales.remove(atOffsets: offsets)
        moveCurrentLocaleFirst()
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
