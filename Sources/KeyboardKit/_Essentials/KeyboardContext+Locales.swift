//
//  KeyboardContext+Locales.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {

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
}

extension KeyboardContext {

    /// This is internal until we find a better name for it.
    var selectableLocales: [Locale] {
        let locales = settings.addedLocales
        return locales.isEmpty ? self.locales : locales
    }
}
