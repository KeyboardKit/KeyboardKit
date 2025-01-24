//
//  KeyboardContext+Locales.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {
    
    /// All ``Keyboard/Settings/addedLocales`` or ``locales``.
    var enabledLocales: [Locale] {
        let addedLocales = settings.addedLocales
        return addedLocales.isEmpty ? locales : addedLocales
    }
    
    /// Whether the context has multiple enabled locales.
    var hasMultipleEnabledLocales: Bool {
        enabledLocales.count > 1
    }
    
    /// Whether the space bar should apply a trailing locale
    /// context menu.
    var shouldAddLocaleContextMenuToSpaceBar: Bool {
        guard hasMultipleEnabledLocales else { return false }
        return spaceLongPressBehavior.shouldAddTrailingLocaleContextMenu
    }

    /// Select the next locale in the selectable locales.
    func selectNextLocale() {
        let locales = enabledLocales
        let fallback = locales.first ?? locale
        let firstIndex = locales.firstIndex(of: locale)
        guard let index = firstIndex else { return locale = fallback }
        let nextIndex = index.advanced(by: 1)
        guard locales.count > nextIndex else { return locale = fallback }
        locale = locales[nextIndex]
    }
}
